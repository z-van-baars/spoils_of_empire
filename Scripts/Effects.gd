extends Node

enum Eft {
	BulletImpact,
	ExplosionSmall,
	ExplosionMedium,
	ExplosionLarge,
	PlasmaExplosionSmall,
	PlasmaExplosionMedium,
	LaserExplosionSmall,
	LaserExplosion,
	PulseExplosionSmall,
	PulseExplosion
}

var light_level = {
	Eft.BulletImpact: 1,
	Eft.ExplosionSmall: 5,
	Eft.ExplosionMedium: 10,
	Eft.ExplosionLarge: 30,
	Eft.PlasmaExplosionSmall: 5,
	Eft.PlasmaExplosionMedium: 10,
	Eft.LaserExplosionSmall: 5,
	Eft.LaserExplosion: 10,
	Eft.PulseExplosionSmall: 5,
	Eft.PulseExplosion: 10
}

var light_range = {
	Eft.BulletImpact: 1,
	Eft.ExplosionSmall: 10,
	Eft.ExplosionMedium: 20,
	Eft.ExplosionLarge: 50,
	Eft.PlasmaExplosionSmall: 10,
	Eft.PlasmaExplosionMedium: 20,
	Eft.LaserExplosionSmall: 10,
	Eft.LaserExplosion: 20,
	Eft.PulseExplosionSmall: 10,
	Eft.PulseExplosion: 20
}

var light_color = {
	Eft.BulletImpact: Color.orangered,
	Eft.ExplosionSmall: Color.orangered,
	Eft.ExplosionMedium: Color.orangered,
	Eft.ExplosionLarge: Color.orangered,
	Eft.PlasmaExplosionSmall: Color.aqua,
	Eft.PlasmaExplosionMedium: Color.aqua,
	Eft.LaserExplosionSmall: Color.crimson,
	Eft.LaserExplosion: Color.crimson,
	Eft.PulseExplosionSmall: Color.green,
	Eft.PulseExplosion: Color.green
}

var animation_name = {
	Eft.BulletImpact: ["explosion_small_1"],
	Eft.ExplosionSmall: ["explosion_small_1"],
	Eft.ExplosionMedium: ["explosion_medium_1", "explosion_medium_2", "explosion_medium_3", "explosion_medium_4"],
	Eft.ExplosionLarge: ["explosion_large_1"],
	Eft.PlasmaExplosionSmall: ["plasma_explosion_small_1", "plasma_explosion_small_2"],
	Eft.PlasmaExplosionMedium: ["plasma_explosion_small_1"],
	Eft.LaserExplosionSmall: ["explosion_small_1"],
	Eft.LaserExplosion: ["explosion_small_1"],
	Eft.PulseExplosionSmall: ["explosion_small_1"],
	Eft.PulseExplosion: ["explosion_small_1"]
}

func get_animation_name(effect_type):
	return Tools.r_choice(animation_name[effect_type])

func get_light_color(effect_type):
	return light_color[effect_type]

func get_light_radius(effect_type):
	return light_range[effect_type]

func get_light_intensity(effect_type):
	return light_level[effect_type]
