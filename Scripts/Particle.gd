extends RigidBody


func load_particle_type(particle_type):
	linear_velocity = Vector3(
		Tools.rng.randf_range(-4, 4),
		Tools.rng.randf_range(2, 10),
		Tools.rng.randf_range(-4, 4))
	add_to_group("particles")
	$Timer.start(Tools.rng.randf_range(1.0, 2.5))
	var random_size_min = _Particles.get_size_min(particle_type)
	var random_size_max = _Particles.get_size_max(particle_type)
	scale *= Tools.rng.randf_range(random_size_min, random_size_max)
	$Sprite3D.texture = _Particles.get_texture(particle_type)
	$Sprite3D.material_override.albedo_color = _Particles.get_modulation(particle_type)
	#if you add in light code remember to turn the $omni_light visible field back to true

func _on_Timer_timeout():
	kill()

func kill():
	remove_from_group("particles")
	queue_free()

func set_color(input_color):
	$Sprite3D.material_override.albedo_color = input_color


