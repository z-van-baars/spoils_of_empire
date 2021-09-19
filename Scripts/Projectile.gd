extends RigidBody

signal impact

var particle_scn = preload("res://Scenes/Particle.tscn")
var effect_scn = preload("res://Scenes/Effect.tscn")
var decal_scn = preload("res://Scenes/Decal.tscn")
var world
var SPEED
var DAMAGE
var impact_effect

func _ready():
	world = get_tree().root.get_node("World")
	add_to_group("projectiles")

func load_projectile_type(projectile_type):
	SPEED = Projectiles.get_speed(projectile_type)
	DAMAGE = Projectiles.get_damage(projectile_type)
	$Sprite3D.texture = Projectiles.get_texture(projectile_type)
	$Sprite3D.material_override.albedo_color = Projectiles.get_modulation(projectile_type)
	if Projectiles.get_light_level(projectile_type):
		$OmniLight.light_energy = Projectiles.get_light_level(projectile_type)
		$OmniLight.omni_range = Projectiles.get_light_range(projectile_type)
		$OmniLight.light_color =  Projectiles.get_light_color(projectile_type)
	impact_effect = Projectiles.get_impact_effect(projectile_type)
	if Projectiles.get_kill_time(projectile_type):
		$Timer.start(Projectiles.get_kill_time(projectile_type))
	else:
		$Timer.start()

func _physics_process(delta):
	var forward_dir = -global_transform.basis.z.normalized()
	global_translate(forward_dir * SPEED * delta)

func _on_death():
	remove_from_group("projectiles")
	queue_free()

func spawn_particles():
	for _pp in Tools.rng.randi_range(3, 8):
		var new_particle = particle_scn.instance()
		world.add_child(new_particle)
		new_particle.load_particle_type(_Particles.Prt.PlasmaSpark)
		new_particle.translation = translation + global_transform.basis.z.normalized()

func spawn_effect():
	if impact_effect == null:
		return
	var new_effect = effect_scn.instance()
	world.add_child(new_effect)
	new_effect.load_effect_type(impact_effect)
	var forward_dir = -global_transform.basis.z.normalized()
	new_effect.translation = translation + global_transform.basis.z.normalized() * 1.75
	# a solution here might be to goose the translation origin by an amount corresponding to the dimensions
	# of the effect's source frames animation size, the amount visible through an occluding mesh seems to be
	# 0.75 for 16px
	# new_effect.translation = translation + (translation.direction_to(world.get_player_pos())).normalized()
	
	"""print(
		str(stepify(forward_dir.x, 0.01)) + ", " +
		str(stepify(forward_dir.y, 0.01)) + ", " +
		str(stepify(forward_dir.z, 0.01)))"""
	# new_effect.translation = translation - (forward_dir * SPEED * last_delta).normalized() * 1.1
	# new_effect.translation = translation


func _on_Timer_timeout():
	_on_death()

func set_color(input_color):
	$Sprite3D.material_override.albedo_color = input_color

func _on_Area_body_entered(body):
	if world.is_player(body):
		return 
	if body == self:
		return
		
	if body.has_method("take_damage"):
		body.take_damage(DAMAGE, global_transform)

	spawn_particles()
	spawn_decal()
	spawn_effect()
	_on_death()

func spawn_decal():
	var new_decal = decal_scn.instance()
	world.add_child(new_decal)
	new_decal.load_decal_type(Decals.Dcl.BulletHole)
	new_decal.translation = translation + global_transform.basis.z.normalized()

func _on_Area_body_shape_entered(body_id, body, body_shape, area_shape):
	pass # Replace with function body.


func _on_Projectile_body_entered(body):

	pass # Replace with function body.


func _on_Projectile_body_shape_entered(body_id, body, body_shape, local_shape):
	pass # Replace with function body.
