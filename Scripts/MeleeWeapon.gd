extends Spatial
signal impact
onready var world_node = get_tree().root.get_node("World")
onready var particle_scn = preload("res://Scenes/Particle.tscn")
onready var player = null
onready var raycast = $RayCast
onready var area = $Area
var weapon_type = null
var damage = null

func load_weapon(new_weapon_type):
	weapon_type = new_weapon_type
	damage = Weapons.get_damage(weapon_type)

func fire():
	raycast.force_raycast_update()
	
	var bodies = area.get_overlapping_bodies()
	var areas = area.get_overlapping_areas()
	for body in bodies:
		if body == player:
			continue

		if body.has_method("take_damage"):
			body.take_damage(damage, area.global_transform)
		if not raycast.is_colliding():
			continue
		var coll = raycast.get_collider()
		if coll == player:
			continue
		spawn_particles()
		emit_signal("impact")

func play_sound(soundfile):
	soundfile.play()

func spawn_particles():
	for _pp in range(Tools.rng.randi_range(2, 4)):
		var new_particle = particle_scn.instance()
		world_node.add_child(new_particle)
		new_particle.translation = raycast.get_collision_point() + raycast.get_collision_normal()
		
