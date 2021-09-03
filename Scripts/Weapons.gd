extends Node

enum WeaponTypes {
	Bolter,
	Shotgun,
	Axe
}

var weapon_names = {
	WeaponTypes.Bolter: "Bolter",
	WeaponTypes.Shotgun: "Shotgun",
	WeaponTypes.Axe: "Axe"
}

var weapon_damage = {
	WeaponTypes.Bolter: 10,
	WeaponTypes.Shotgun: 10,
	WeaponTypes.Axe: 10
}

func get_damage(weapon_type):
	return weapon_damage[weapon_type]
