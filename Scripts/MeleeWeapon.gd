extends Spatial
const DAMAGE = 10
onready var world_node = get_tree().root.get_node("World")
onready var particle_scn = preload("res://Scenes/Particle.tscn")
onready var player = null
onready var raycast = $RayCast
onready var area = $Area


func fire():
	raycast.force_raycast_update()
	
	var bodies = area.get_overlapping_bodies()

	for body in bodies:
		if body == player:
			continue

		if body.has_method("take_damage"):
			body.take_damage(DAMAGE, area.global_transform)
		if not raycast.is_colliding():
			return
		var coll = raycast.get_collider()
		if coll == player:
			continue
		spawn_particles()

func spawn_particles():
	for _pp in range(Tools.rng.randi_range(3, 8)):
		var new_particle = particle_scn.instance()
		world_node.add_child(new_particle)
		new_particle.translation = raycast.get_collision_point() + raycast.get_collision_normal()
		
