extends Spatial

const DAMAGE = 10

onready var raycast = $RayCast
onready var world_node = get_tree().root.get_node("World")

onready var projectile_scn = preload("res://Scenes/Projectile.tscn")
onready var particle_scn = preload("res://Scenes/Particle.tscn")

onready var player = null

func fire():
	# raycast.look_at(player.get_node("RotationHelper/WeaponAimPoint").global_transform.origin, Vector3(0, 1, 0))
	raycast.force_raycast_update()
	if not raycast.is_colliding():
		return
	var coll = raycast.get_collider()
	if coll == player:
		return
	spawn_particles()

func spawn_particles():
	for _pp in range(Tools.rng.randi_range(3, 8)):
		var new_particle = particle_scn.instance()
		world_node.add_child(new_particle)
		new_particle.translation = raycast.get_collision_point()#  + raycast.get_collision_normal().normalized() * 0.01
