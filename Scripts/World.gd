extends Spatial

onready var player = get_node("Player")
onready var corn_drop = preload("res://Scenes/Drop.tscn")
onready var particle_scn = preload("res://Scenes/Particle.tscn")

func _ready():
	$Drop._ready()
	# generate_starfield()

func is_player(entity):
	return entity == player

func _on_Entity_new_drop(drop_type):
	var new_drop = corn_drop.instance()
	add_child(new_drop)
	new_drop.setup(Drops.corn_drop_stats)
	new_drop.add_to_group("drops")

func generate_starfield():
	for _ss in range(Tools.rng.randi_range(1900, 2100)):
		var new_star = particle_scn.instance()
		add_child(new_star)
		new_star.add_to_group("stars")
		new_star.translation = Vector3(
			Tools.rng.randf_range(-1, 1),
			Tools.rng.randf_range(-1, 1),
			Tools.rng.randf_range(-1, 1)).normalized() * Tools.rng.randf_range(100, 300)
		new_star.set_color(Color.white)
		new_star.gravity_scale = 0
		new_star.get_node("Timer").stop()
		new_star.linear_velocity = Vector3.ZERO
