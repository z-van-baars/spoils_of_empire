extends Spatial

signal impact

var particle_scn = preload("res://Scenes/Particle.tscn")
var world
var SPEED = 70
var DAMAGE = 10
var KILL_TIMER = 4


var hit_something = false

func _ready():
	world = get_tree().root.get_node("World")
	add_to_group("projectiles")
	$Timer.start(KILL_TIMER)


func _physics_process(delta):
	var forward_dir = -global_transform.basis.z.normalized()
	global_translate(forward_dir * SPEED * delta)


func _on_Area_body_shape_entered(body_id, body, body_shape, area_shape):
	"""Doesn't trigger for current enemy entities"""
	return
	if body.has_method("kill"):
		body.kill()

func _on_death():
	spawn_particles()
	remove_from_group("projectiles")
	queue_free()

func spawn_particles():
	for _pp in Tools.rng.randi_range(3, 8):
		var new_particle = particle_scn.instance()
		world.add_child(new_particle)
		new_particle.translation = translation + global_transform.basis.z.normalized()


func _on_Timer_timeout():
	_on_death()

func set_color(input_color):
	$Sprite3D.material_override.albedo_color = input_color

func _on_Area_body_entered(body):
	if not world.is_player(body):
		if body.has_method("take_damage"):
			body.take_damage(DAMAGE, global_transform)
		_on_death()
