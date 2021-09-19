extends StaticBody


func load_decal_type(decal_type):
	add_to_group("decals")
	# var random_size_min = _Particles.get_size_min(decal_type)
	# var random_size_max = _Particles.get_size_max(decal_type)
	# scale *= Tools.rng.randf_range(random_size_min, random_size_max)
	$Sprite3D.texture = Decals.get_texture(decal_type)
	$Sprite3D.material_override.albedo_color = Decals.get_modulation(decal_type)
	#if you add in light code remember to turn the $omni_light visible field back to true
func kill():
	remove_from_group("decals")
	queue_free()

func set_color(input_color):
	$Sprite3D.material_override.albedo_color = input_color
