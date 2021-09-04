extends KinematicBody

const GRAVITY = -24.8
var vel = Vector3()
const MAX_SPEED = 12
const JUMP_SPEED = 12
const ACCEL = 16

var dir = Vector3()
var shooting = false

const DEACCEL= 16
const MAX_SLOPE_ANGLE = 40

var camera
var rotation_helper

var MOUSE_SENSITIVITY = 0.1

onready var anim_player = $AnimationPlayer
onready var weapon_sprite = $CanvasLayer/Control/BolterSprite
onready var raycast = $RotationHelper/RayCast
onready var world_node = get_tree().root.get_node("World")
onready var weapon_slot = 0
onready var weapons = [
	Weapons.WeaponTypes.Bolter,
	Weapons.WeaponTypes.Shotgun,
	Weapons.WeaponTypes.Axe
	]

onready var sounds = {
	"bolter_fire" : [
		$SoundPlayers/BolterFire1,
		$SoundPlayers/BolterFire2,
		$SoundPlayers/BolterFire3],
	"shotgun_fire" : [
		$SoundPlayers/ShotgunFire1,
		$SoundPlayers/ShotgunFire2,
		$SoundPlayers/ShotgunFire3],
	"axe_swing" : [
		$SoundPlayers/AxeSwing1,
		$SoundPlayers/AxeSwing2,
		$SoundPlayers/AxeSwing3],
	"corn pickup": [$SoundPlayers/DropPickup]
}


func _ready():
	# yield(get_tree(), "idle_frame")
	get_tree().call_group("creatures", "set_player", self)
	anim_player.seek(0)
	camera = $RotationHelper/Camera
	rotation_helper = $RotationHelper
	

	var aim_point_pos = $RotationHelper/WeaponAimPoint.global_transform.origin
	for weapon_node in [
		$RotationHelper/GunFirePoints/HitscanPoint,
		$RotationHelper/GunFirePoints/ProjectilePoint,
		$RotationHelper/GunFirePoints/MeleePoint]:
		weapon_node.player = self
		weapon_node.look_at(aim_point_pos, Vector3(0, 1, 0))
		# weapon_node.rotate_object_local(Vector3(0, 1, 0), deg2rad(180))

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	process_input(delta)
	process_movement(delta)
	process_weapons(delta)

func process_weapons(delta):
	if !shooting:
		return
	match weapons[weapon_slot]:
		Weapons.WeaponTypes.Bolter:
			if weapon_sprite.is_playing():
				return
			weapon_sprite.play(Weapons.weapon_names[weapon_slot] + "attack")
			weapon_sprite.set_frame(0)
			Tools.r_choice(sounds["bolter_fire"]).play()
			$RotationHelper/GunFirePoints/ProjectilePoint.fire()
		Weapons.WeaponTypes.Shotgun:
			if weapon_sprite.is_playing():
				return
			weapon_sprite.play(Weapons.weapon_names[weapon_slot] + "attack")
			weapon_sprite.set_frame(0)
			Tools.r_choice(sounds["bolter_fire"]).play()
			$RotationHelper/GunFirePoints/HitscanPoint.fire()
			shooting = false
		Weapons.WeaponTypes.Axe:
			if anim_player.is_playing():
				return
			anim_player.play("axe swing")
			$MeleeTimer.start(0.05)
			shooting = false

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

	# ----------------------------------
	# Capturing/Freeing the cursor
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
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
		get_tree().quit()
	elif event.is_action_pressed("restart"):
		kill()
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
		print("shootah")
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
	Tools.r_choice(sounds[drop.get_drop_name() + " pickup"]).play()

func activate_weapon():
	hide_weapons()
	match get_weapon():
		Weapons.WeaponTypes.Bolter:
			bolter_swap()
		Weapons.WeaponTypes.Shotgun:
			shotgun_swap()
		Weapons.WeaponTypes.Axe:
			axe_swap()

func hide_weapons():
	$CanvasLayer/Control/AxeSprite.hide()
	$CanvasLayer/Control/ShotgunSprite.hide()
	$CanvasLayer/Control/BolterSprite.hide()


func bolter_swap():
	$CanvasLayer/Control/BolterSprite.show()
	weapon_sprite = $CanvasLayer/Control/BolterSprite

func shotgun_swap():
	$CanvasLayer/Control/ShotgunSprite.show()
	weapon_sprite = $CanvasLayer/Control/ShotgunSprite
	
func axe_swap():
	$CanvasLayer/Control/AxeSprite.show()
	weapon_sprite = $CanvasLayer/Control/BolterSprite



func kill():
	print("Player Was Killed!")
	get_tree().reload_current_scene()


func _on_AnimatedSprite_animation_finished():
	weapon_sprite.set_frame(0)
	weapon_sprite.stop()


func _on_MeleeTimer_timeout():
	$RotationHelper/GunFirePoints/MeleePoint.fire()



func _on_WeaponSprite_animation_finished():
	weapon_sprite.set_frame(0)
	weapon_sprite.stop()
