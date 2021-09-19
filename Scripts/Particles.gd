extends Node

enum Prt {
	Fireball,
	Flame,
	SmallFlame,
	Ember,
	Spark,
	ElectricalSpark,
	MuzzleFlare,
	PlasmaBolt,
	PlasmaSpark,
	PlasmaFlare,
	LaserEmber,
	LaserBurst,
	LaserFlare,
	PulseEmber,
	PulseBurst,
	PulseFlare,
	SmokeTiny,
	SmokeSmall,
	SmokeMedium,
	Credits
}

var particle_names = {
	Prt.Fireball: "Fireball",
	Prt.Flame: "Flame",
	Prt.SmallFlame: "Small Flame",
	Prt.Ember: "Ember",
	Prt.Spark: "Spark",
	Prt.ElectricalSpark: "Spark",
	Prt.MuzzleFlare: "Muzzle Flare",
	Prt.PlasmaBolt: "Plasma Bolt",
	Prt.PlasmaSpark: "Plasma Spark",
	Prt.PlasmaFlare: "plasma_flare",
	Prt.LaserEmber: "laser_ember",
	Prt.LaserBurst: "laser_burst",
	Prt.LaserFlare: "laser_flare",
	Prt.PulseEmber: "pulse_ember",
	Prt.PulseBurst: "pulse_burst",
	Prt.PulseFlare: "pulse_flare",
	Prt.SmokeTiny: "smoke_tiny",
	Prt.SmokeSmall: "smoke_small",
	Prt.SmokeMedium: "smoke_medium",
	Prt.Credits: "credits"
}
var directory_string = "res://Assets/art/particles/"
var image_files = {
	Prt.Fireball: [
		load(directory_string + "/medium_fireball_1.png"),
		load(directory_string + "/medium_fireball_2.png"),
		load(directory_string + "/medium_fireball_3.png")],
	Prt.Flame: [
		load(directory_string + "/small_fireball_1.png"),
		load(directory_string + "/small_fireball_2.png"),
		load(directory_string + "/small_fireball_3.png"),
		load(directory_string + "/small_fireball_4.png")],
	Prt.SmallFlame: [
		load(directory_string + "/tiny_fireball_1.png"),
		load(directory_string + "/tiny_fireball_2.png"),
		load(directory_string + "/tiny_fireball_3.png"),
		load(directory_string + "/tiny_fireball_4.png")],
	Prt.Ember: [
		load(directory_string + "/flame_dot_1.png"),
		load(directory_string + "/flame_dot_2.png"),
		load(directory_string + "/flame_dot_3.png"),
		load(directory_string + "/flame_dot_4.png"),
		load(directory_string + "/flame_dot_5.png")],
	Prt.Spark: [
		load(directory_string + "/gray_point_1.png"),
		load(directory_string + "/gray_point_2.png"),
		load(directory_string + "/gray_point_3.png"),
		load(directory_string + "/gray_point_4.png")],
	Prt.ElectricalSpark: [
		load(directory_string + "/gray_point_1.png"),
		load(directory_string + "/gray_point_2.png"),
		load(directory_string + "/gray_point_3.png"),
		load(directory_string + "/gray_point_4.png")],
	Prt.MuzzleFlare: [
		load(directory_string + "/small_fireball_1.png"),
		load(directory_string + "/small_fireball_2.png"),
		load(directory_string + "/small_fireball_3.png"),
		load(directory_string + "/small_fireball_4.png")],
	Prt.PlasmaBolt: [
		load(directory_string + "/small_fireball_1.png"),
		load(directory_string + "/small_fireball_2.png"),
		load(directory_string + "/small_fireball_3.png"),
		load(directory_string + "/small_fireball_4.png")],
	Prt.PlasmaSpark: [
		load(directory_string + "/gray_point_1.png"),
		load(directory_string + "/gray_point_2.png"),
		load(directory_string + "/gray_point_3.png"),
		load(directory_string + "/gray_point_4.png")],
	Prt.PlasmaFlare: [
		load(directory_string + "/small_fireball_1.png"),
		load(directory_string + "/small_fireball_2.png"),
		load(directory_string + "/small_fireball_3.png"),
		load(directory_string + "/small_fireball_4.png")],
	Prt.LaserEmber: [
		load(directory_string + "/gray_point_1.png"),
		load(directory_string + "/gray_point_2.png"),
		load(directory_string + "/gray_point_3.png"),
		load(directory_string + "/gray_point_4.png")],
	Prt.LaserBurst: [
		load(directory_string + "/small_fireball_1.png"),
		load(directory_string + "/small_fireball_2.png"),
		load(directory_string + "/small_fireball_3.png"),
		load(directory_string + "/small_fireball_4.png")],
	Prt.LaserFlare: [
		load(directory_string + "/small_fireball_1.png"),
		load(directory_string + "/small_fireball_2.png"),
		load(directory_string + "/small_fireball_3.png"),
		load(directory_string + "/small_fireball_4.png")],
	Prt.PulseEmber: [
		load(directory_string + "/gray_point_1.png"),
		load(directory_string + "/gray_point_2.png"),
		load(directory_string + "/gray_point_3.png"),
		load(directory_string + "/gray_point_4.png")],
	Prt.PulseBurst: [
		load(directory_string + "/small_fireball_1.png"),
		load(directory_string + "/small_fireball_2.png"),
		load(directory_string + "/small_fireball_3.png"),
		load(directory_string + "/small_fireball_4.png")],
	Prt.PulseFlare: [
		load(directory_string + "/small_fireball_1.png"),
		load(directory_string + "/small_fireball_2.png"),
		load(directory_string + "/small_fireball_3.png"),
		load(directory_string + "/small_fireball_4.png")],
	Prt.SmokeTiny: [
		load(directory_string + "/small_fireball_1.png")],
	Prt.SmokeSmall: [
		load(directory_string + "/small_fireball_1.png")],
	Prt.SmokeMedium: [
		load(directory_string + "/smoke_1.png"),
		load(directory_string + "/smoke_2.png"),
		load(directory_string + "/smoke_3.png"),
		load(directory_string + "/smoke_4.png"),
		load(directory_string + "/smoke_5.png"),
		load(directory_string + "/smoke_6.png")],
	Prt.Credits: [
		load(directory_string + "/credits_1.png"),
		load(directory_string + "/credits_2.png"),
		load(directory_string + "/credits_3.png"),
		load(directory_string + "/credits_4.png"),
		load(directory_string + "/credits_5.png")]
	}
var modulation = {
	Prt.Spark: Color.orange * 2,
	Prt.ElectricalSpark: Color.yellow * 2,
	Prt.PlasmaBolt: Color.teal,
	Prt.PlasmaSpark: Color.teal,
	Prt.PlasmaFlare: Color.teal,
	Prt.LaserEmber: Color.crimson,
	Prt.LaserBurst: Color.crimson,
	Prt.LaserFlare: Color.crimson,
	Prt.PulseEmber: Color.green,
	Prt.PulseBurst: Color.green,
	Prt.PulseFlare: Color.green
}

var lifespan = {
	Prt.Flame: 3.0,
	Prt.Ember: 3.0,
	Prt.MuzzleFlare: 0.15,
	Prt.PlasmaBolt: 3.0,
	Prt.PlasmaSpark: 3.0,
	Prt.PlasmaFlare: 0.15,
	Prt.LaserEmber: 3.0,
	Prt.LaserBurst: 3.0,
	Prt.LaserFlare: 0.15,
	Prt.PulseEmber: 3.0,
	Prt.PulseBurst: 3.0,
	Prt.PulseFlare: 0.15,
	Prt.SmokeTiny: 4.0,
	Prt.SmokeSmall: 4.0,
	Prt.SmokeMedium: 4.0
}


func get_texture(particle_type):
	return Tools.r_choice(image_files[particle_type]).duplicate()

func get_modulation(particle_type):
	if modulation.has(particle_type):
		return modulation[particle_type]
	return Color.white

func get_size_min(particle_type):
	return 1.0

func get_size_max(particle_type):
	return 1.0
