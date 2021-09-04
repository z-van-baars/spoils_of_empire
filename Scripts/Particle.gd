extends RigidBody

func _ready():
	linear_velocity = Vector3(
		Tools.rng.randf_range(-4, 4),
		Tools.rng.randf_range(2, 10),
		Tools.rng.randf_range(-4, 4))
	add_to_group("particles")
	$Timer.start(Tools.rng.randf_range(1.0, 2.5))
	scale *= Tools.rng.randf_range(0.25, 1.5)

func _on_Timer_timeout():
	kill()

func kill():
	remove_from_group("particles")
	queue_free()

func set_color(input_color):
	$Sprite3D.material_override.albedo_color = input_color * 10


