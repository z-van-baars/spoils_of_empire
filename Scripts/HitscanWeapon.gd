extends Spatial

onready var raycast = $RayCast
onready var world_node = get_tree().root.get_node("World")

onready var projectile_scn = preload("res://Scenes/Projectile.tscn")
onready var particle_scn = preload("res://Scenes/Particle.tscn")
onready var decal_scn = preload("res://Scenes/Decal.tscn")
onready var effect_scn = preload("res://Scenes/Effect.tscn")

onready var player = null

var weapon_type = null
var damage = null

func load_weapon(new_weapon_type):
	weapon_type = new_weapon_type
	damage = Weapons.get_damage(weapon_type)


func fire():
	var aim_position = player.get_node("RotationHelper/WeaponAimPoint").global_transform.origin
	for _pp in range(Weapons.get_n_shots(weapon_type)):
		var spread_offset = Weapons.get_spread_offset(weapon_type)
		var spread_pos = aim_position.rotated(Vector3(1, 0, 0), spread_offset.x)
		spread_pos = spread_pos.rotated(Vector3(0, 1, 0), spread_offset.y)
		spread_pos.y -= 1.15
		raycast.look_at(spread_pos, Vector3(0, 1, 0))
		raycast.force_raycast_update()
		if not raycast.is_colliding():
			return
		var coll = raycast.get_collider()
		if coll == player:
			return
		if coll.has_method("take_damage"):
			coll.take_damage(damage, global_transform)
		spawn_particles()
		spawn_decal()
		spawn_effect()
		raycast.look_at(aim_position, Vector3(0, 1, 0))

func spawn_decal():
	var new_decal = decal_scn.instance()
	world_node.add_child(new_decal)
	new_decal.load_decal_type(Decals.Dcl.BulletHole)
	new_decal.translation = raycast.get_collision_point()# + raycast.get_collision_normal().normalized() * 1

func spawn_effect():
	var new_effect = effect_scn.instance()
	world_node.add_child(new_effect)
	new_effect.load_effect_type(Effects.Eft.BulletImpact)
	new_effect.scale *= 0.2
	# new_effect.translation = raycast.get_collision_point() + raycast.get_collision_normal().normalized() * 10
	new_effect.translation = raycast.get_collision_point()# + (raycast.get_collision_point().direction_to(world_node.get_player_pos())).normalized() * 1

func spawn_particles():
	for _pp in range(Tools.rng.randi_range(1, 2)):
		var new_particle = particle_scn.instance()
		world_node.add_child(new_particle)
		new_particle.load_particle_type(_Particles.Prt.Spark)
		new_particle.translation = raycast.get_collision_point()#  + raycast.get_collision_normal().normalized() * 0.01
