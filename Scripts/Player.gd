extends KinematicBody

const GRAVITY = -24.8
const MAX_SPEED = 20
const JUMP_SPEED = 16
const ACCEL = 16
const DEACCEL = 16
const MAX_SLOPE_ANGLE = 40
var vel = Vector3()
var dir = Vector3()
var shooting = false

var camera
var rotation_helper

var MOUSE_SENSITIVITY = 0.1
# ----------------------------------
# Animation Stuff
onready var weapon_sprite = $RotationHelper/WeaponArmature/WeaponSprite
onready var weapon_animator = $RotationHelper/WeaponArmature/WeaponAnimationPlayer
onready var world_node = get_tree().root.get_node("World")

onready var weapon_slot = 0

onready var weapons_all = [
	Weapons.Wpn.Bolter,
	Weapons.Wpn.PlasmaRifle,
	Weapons.Wpn.PistolA,
	Weapons.Wpn.PistolB,
	Weapons.Wpn.SmgA,
	Weapons.Wpn.SmgB,
	Weapons.Wpn.AlienSmgA,
	Weapons.Wpn.AlienSmgB,
	Weapons.Wpn.AlienSmgC,
	Weapons.Wpn.PulseRifle,
	Weapons.Wpn.CombatShotgun,
	Weapons.Wpn.AK47,
	Weapons.Wpn.FlameThrower,
	Weapons.Wpn.MeltaGun,
	Weapons.Wpn.PlasmaCannon,
	Weapons.Wpn.Axe
	]

onready var weapons = [


	Weapons.Wpn.PistolA,
	Weapons.Wpn.CombatShotgun,
	Weapons.Wpn.SmgB,
	Weapons.Wpn.AK47,
	Weapons.Wpn.PlasmaRifle,
	Weapons.Wpn.PulseRifle,
	Weapons.Wpn.FlameThrower,
	Weapons.Wpn.Axe
	]
onready var audio_player = $SoundPlayers/AudioStreamPlayer
onready var ammo  = []

func _ready():
	
	# yield(get_tree(), "idle_frame")
	get_tree().call_group("creatures", "set_player", self)
	camera = $RotationHelper/Camera
	rotation_helper = $RotationHelper
	set_initial_weapon_ammo()
	activate_weapon()
	
	var aim_point_pos = $RotationHelper/WeaponAimPoint.global_transform.origin
	for weapon_node in [
		$RotationHelper/GunFirePoints/HitscanPoint,
		$RotationHelper/GunFirePoints/ProjectilePoint,
		$RotationHelper/GunFirePoints/MeleePoint]:
		weapon_node.player = self
		weapon_node.look_at(aim_point_pos, Vector3(0, 1, 0))
		# weapon_node.rotate_object_local(Vector3(0, 1, 0), deg2rad(180))

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func set_initial_weapon_ammo():
	for each in weapons:
		ammo.append(Weapons.get_clip_size(each))

func _physics_process(delta):
	process_input(delta)
	process_movement(delta)
	process_weapons(delta)

func process_weapons(delta):
	if !shooting or weapon_animator.is_playing():
		return
	if ammo[weapon_slot] == 0:
		return
		#swap these once we have dryfire
		# Tools.r_choice(sounds["dryfire"][weapons[weapon_slot]]).play()
		
	match Weapons.get_munition_type(weapons[weapon_slot]):
		Weapons.Munition.Projectile:
			audio_player.set_stream(Weapons.get_fire_sound(weapons[weapon_slot]))
			audio_player.play()

			$RotationHelper/GunFirePoints/ProjectilePoint.fire()
			ammo[weapon_slot] = max(ammo[weapon_slot] - 1, 0)
			update_ammo_counter()
		Weapons.Munition.Hitscan:
			weapon_animator.play()
			audio_player.set_stream(Weapons.get_fire_sound(weapons[weapon_slot]))
			audio_player.play()
			$RotationHelper/GunFirePoints/HitscanPoint.fire()
			ammo[weapon_slot] = max(ammo[weapon_slot] - 1, 0)
			update_ammo_counter()
		Weapons.Munition.Melee:
			audio_player.set_stream(Weapons.get_swing_sound(weapons[weapon_slot]))
			audio_player.play()
			$MeleeTimer.start(Weapons.get_attack_speed(weapons[weapon_slot]))
	shooting = Weapons.is_continuous_fire(weapons[weapon_slot])
	weapon_animator.play()

func process_input(delta):

	# ----------------------------------
	# Walking
	dir = Vector3()
	var cam_xform = camera.get_global_transform()

	var input_movement_vector = Vector2()

	if Input.is_action_pressed("move_forward"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("move_backward"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("move_left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_movement_vector.x += 1
	if Input.is_action_just_pressed("next_weapon"):
		cycle_weapon()

	input_movement_vector = input_movement_vector.normalized()

	# Basis vectors are already normalized.
	dir += -cam_xform.basis.z * input_movement_vector.y
	dir += cam_xform.basis.x * input_movement_vector.x
	# ----------------------------------

	# ----------------------------------
	# Jumping
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			vel.y = JUMP_SPEED
	# ----------------------------------

func process_movement(delta):
	dir.y = 0
	dir = dir.normalized()

	vel.y += delta * GRAVITY

	var hvel = vel
	hvel.y = 0

	var target = dir
	target *= MAX_SPEED

	var accel
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL

	hvel = hvel.linear_interpolate(target, accel * delta)
	vel.x = hvel.x
	vel.z = hvel.z
	vel = move_and_slide(vel, Vector3(0, 1, 0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))

func _input(event):
	if event.is_action_pressed("exit"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event.is_action_pressed("reload"):
		ammo[weapon_slot] = Weapons.get_clip_size(weapons[weapon_slot])
		update_ammo_counter()
	elif event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		# I needed to invert this to get look-up / look-down to work
		# but it doesn't mention it in the tutorial
		rotation_helper.rotate_x(-deg2rad(event.relative.y * MOUSE_SENSITIVITY))
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))

		var camera_rot = rotation_helper.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		rotation_helper.rotation_degrees = camera_rot
	elif event.is_action_pressed("shoot"):
		shooting = true
	elif event.is_action_released("shoot"):
		shooting = false



func get_weapon():
	return weapons[weapon_slot]

func cycle_weapon():
	weapon_slot += 1
	if weapon_slot >= weapons.size():
		weapon_slot = 0
	activate_weapon()

func _on_Drop_pickup(drop):
	audio_player.set_stream(load("res://Assets/sound/effects/notify.ogg"))

func update_weapon_portrait():

	var portrait = $CanvasLayer/HUD/LeftHandPortrait/Panel
	portrait.get_node("WeaponSprite").texture = Weapons.get_texture(weapons[weapon_slot])

func update_ammo_counter():
	var portrait = $CanvasLayer/HUD/LeftHandPortrait/Panel
	portrait.get_node("AmmoCounter").text = str(ammo[weapon_slot])
	portrait.get_node("AmmoCounter").show()
	if ammo[weapon_slot] == -1:
		portrait.get_node("AmmoCounter").hide()
	

func activate_weapon():
	weapon_sprite.flip_h = false
	weapon_sprite.texture = Weapons.get_texture(weapons[weapon_slot])
	activate_hardpoint()
	if (Weapons.get_weapon_type(weapons[weapon_slot]) == Weapons.WeaponTypes.Melee or
		Weapons.get_weapon_type(weapons[weapon_slot]) == Weapons.WeaponTypes.Thrown):
		weapon_sprite.flip_h = true
		weapon_animator.play(
			Weapons.get_animation_prefix_string(weapons[weapon_slot]) +
			"_swing")
	else:
		weapon_animator.play(
			Weapons.get_animation_prefix_string(weapons[weapon_slot]) +
			"_fire")
	weapon_animator.seek(0, true)
	weapon_animator.stop()
	update_weapon_portrait()
	update_ammo_counter()

func hide_weapon():
	$RotationHelper/WeaponArmature/WeaponSprite.hide()

func draw_weapon():
	$RotationHelper/WeaponArmature/WeaponSprite.show()

func activate_hardpoint():
	$RotationHelper/WeaponArmature/WeaponSprite/OmniLight.visible = true
	if Weapons.get_munition_type(weapons[weapon_slot]) == Weapons.Munition.Projectile:
		$RotationHelper/GunFirePoints/ProjectilePoint.load_weapon(weapons[weapon_slot])
	elif Weapons.get_munition_type(weapons[weapon_slot]) == Weapons.Munition.Hitscan:
		$RotationHelper/GunFirePoints/HitscanPoint.load_weapon(weapons[weapon_slot])
	else:
		$RotationHelper/WeaponArmature/WeaponSprite/OmniLight.visible = false
		$RotationHelper/GunFirePoints/MeleePoint.load_weapon(weapons[weapon_slot])

func kill():
	print("Player Was Killed!")
	get_tree().reload_current_scene()


func _on_MeleeTimer_timeout():
	$RotationHelper/GunFirePoints/MeleePoint.fire()

func _on_Melee_weapon_impact():
	audio_player.set_stream(Weapons.get_impact_sound(weapons[weapon_slot]))
	audio_player.play()

func _on_WeaponAnimationPlayer_animation_finished(anim_name):
	return
	if !shooting:
		weapon_animator.stop()
		return
	weapon_animator.play()
