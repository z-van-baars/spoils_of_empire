extends Node

enum Prj {
	BolterShell,
	Bullet,
	PlasmaBolt,
	LaserBurst,
	PulseBurst,
	Flame}

var physics_data = {
	Prj.Flame: 1}

var lifespan = {
	Prj.Flame: 4.0
}

var damage = {
	Prj.BolterShell: 10,
	Prj.Bullet: 6,
	Prj.PlasmaBolt: 14,
	Prj.LaserBurst: 8,
	Prj.PulseBurst: 6,
	Prj.Flame: 3
}

var speed = {
	Prj.BolterShell: 225,
	Prj.Bullet: 100,
	Prj.PlasmaBolt: 50,
	Prj.LaserBurst: 60,
	Prj.PulseBurst: 80,
	Prj.Flame: 10
}

var light_level = {
	Prj.PlasmaBolt: 30,
	Prj.LaserBurst: 30,
	Prj.PulseBurst: 30,
	Prj.Flame: 30
}

var light_range = {
	Prj.PlasmaBolt: 10.0,
	Prj.LaserBurst: 5.0,
	Prj.PulseBurst: 5.0,
	Prj.Flame: 20.0
}

var light_color = {
	Prj.PlasmaBolt: Color.aqua,
	Prj.LaserBurst: Color.crimson,
	Prj.PulseBurst: Color.green,
	Prj.Flame: Color.orangered
}

var modulation = {
	Prj.PlasmaBolt: Color.aqua,
	Prj.LaserBurst: Color.crimson * 1.1,
	Prj.PulseBurst: Color.green * 1.1
}

var impact_effect = {
	Prj.BolterShell: Effects.Eft.ExplosionSmall,
	Prj.Bullet: Effects.Eft.ExplosionSmall,
	Prj.PlasmaBolt: Effects.Eft.PlasmaExplosionSmall,
	Prj.LaserBurst: Effects.Eft.PlasmaExplosionSmall,
	Prj.PulseBurst: Effects.Eft.PlasmaExplosionSmall,
	Prj.Flame: Effects.Eft.PlasmaExplosionMedium}

var directory_string = "res://Assets/art/particles/"

var image_files = {
	Prj.BolterShell: [
		load(directory_string + "/medium_fireball_1.png")
		],
	Prj.Bullet: [
		load(directory_string + "/medium_fireball_1.png")
		],
	Prj.PlasmaBolt: [
		load(directory_string + "/medium_gray_blob_1.png"),
		load(directory_string + "/medium_gray_blob_2.png")
		],
	Prj.LaserBurst: [
		load(directory_string + "/medium_fireball_1.png")
		],
	Prj.PulseBurst: [
		load(directory_string + "/small_fireball_1.png"),
		load(directory_string + "/small_fireball_2.png"),
		load(directory_string + "/small_fireball_3.png")
		],
	Prj.Flame: [
		load(directory_string + "/medium_fireball_1.png")
		]
	}

func get_texture(proj_type):
	return Tools.r_choice(image_files[proj_type]).duplicate()

func get_physics(proj_type):
	if physics_data.has(proj_type):
		return physics_data[proj_type]
	return null

func get_kill_time(proj_type):
	if lifespan.has(proj_type):
		return lifespan[proj_type]
	return null

func get_speed(proj_type):
	return speed[proj_type]

func get_damage(proj_type):
	return damage[proj_type]

func get_light_level(proj_type):
	return null
	if light_level.has(proj_type):
		return light_level[proj_type]

func get_modulation(proj_type):
	if modulation.has(proj_type):
		return modulation[proj_type]
	return Color.white

func get_light_range(proj_type):
	if light_range.has(proj_type):
		return light_range[proj_type]
	return 5.0

func get_light_color(proj_type):
	if light_color.has(proj_type):
		return light_color[proj_type]
	return null

func get_impact_effect(proj_type):
	return impact_effect[proj_type]
