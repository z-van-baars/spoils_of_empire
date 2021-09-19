extends Node

enum Wpn {
	Bolter,
	PlasmaRifle,
	PistolA,
	PistolB,
	SmgA,
	SmgB,
	AlienSmgA,
	AlienSmgB,
	AlienSmgC,
	PulseRifle,
	CombatShotgun,
	AK47,
	FlameThrower,
	MeltaGun,
	PlasmaCannon,
	Axe
}
enum WeaponTypes {
	Melee,
	Thrown,
	Pistol,
	Rifle,
	SMG,
	Shotgun,
	Special,
	Heavy
}
enum Munition {
	Hitscan,
	Projectile,
	Melee
}

var _weapon_names = {
	Wpn.Bolter: "Bolter",
	Wpn.PlasmaRifle: "Plasma Rifle",
	Wpn.PistolA: "Pistol A",
	Wpn.PistolB: "Pistol B",
	Wpn.SmgA: "SMG A",
	Wpn.SmgB: "SMG B",
	Wpn.AlienSmgA: "Alien SMG A",
	Wpn.AlienSmgB: "Alien SMG B",
	Wpn.AlienSmgC: "Alien SMG C",
	Wpn.PulseRifle: "Pulse Rifle",
	Wpn.CombatShotgun: "Combat Shotgun",
	Wpn.AK47: "AK-47",
	Wpn.FlameThrower: "Flamethrower",
	Wpn.MeltaGun: "Meltagun",
	Wpn.PlasmaCannon: "Plasma Cannon",
	Wpn.Axe: "Axe"
}

var _types = {
	Wpn.Bolter: WeaponTypes.Rifle,
	Wpn.PlasmaRifle: WeaponTypes.Rifle,
	Wpn.PistolA: WeaponTypes.Pistol,
	Wpn.PistolB: WeaponTypes.Pistol,
	Wpn.SmgA: WeaponTypes.SMG,
	Wpn.SmgB: WeaponTypes.SMG,
	Wpn.AlienSmgA: WeaponTypes.SMG,
	Wpn.AlienSmgB: WeaponTypes.SMG,
	Wpn.AlienSmgC: WeaponTypes.SMG,
	Wpn.PulseRifle: WeaponTypes.Rifle,
	Wpn.CombatShotgun: WeaponTypes.Shotgun,
	Wpn.AK47: WeaponTypes.Rifle,
	Wpn.FlameThrower: WeaponTypes.Special,
	Wpn.MeltaGun: WeaponTypes.Special,
	Wpn.PlasmaCannon: WeaponTypes.Heavy,
	Wpn.Axe: WeaponTypes.Melee
}

var _munition_type = {
	Wpn.Bolter: Munition.Projectile,
	Wpn.PlasmaRifle: Munition.Projectile,
	Wpn.PistolA: Munition.Hitscan,
	Wpn.PistolB: Munition.Hitscan,
	Wpn.SmgA: Munition.Hitscan,
	Wpn.SmgB: Munition.Hitscan,
	Wpn.AlienSmgA: Munition.Projectile,
	Wpn.AlienSmgB: Munition.Projectile,
	Wpn.AlienSmgC: Munition.Projectile,
	Wpn.PulseRifle: Munition.Projectile,
	Wpn.CombatShotgun: Munition.Hitscan,
	Wpn.AK47: Munition.Hitscan,
	Wpn.FlameThrower: Munition.Projectile,
	Wpn.MeltaGun: Munition.Projectile,
	Wpn.PlasmaCannon: Munition.Projectile,
	Wpn.Axe: Munition.Melee
}

var _clip_size = {
	Wpn.Bolter: 25,
	Wpn.PlasmaRifle: 40,
	Wpn.PistolA: 12,
	Wpn.PistolB: 10,
	Wpn.SmgA: 30,
	Wpn.SmgB: 32,
	Wpn.AlienSmgA: 50,
	Wpn.AlienSmgB: 32,
	Wpn.AlienSmgC: 30,
	Wpn.PulseRifle: 25,
	Wpn.CombatShotgun: 12,
	Wpn.AK47: 30,
	Wpn.FlameThrower: 50,
	Wpn.MeltaGun: 30,
	Wpn.PlasmaCannon: 20,
	Wpn.Axe: -1
}

var _image_dir = "res://Assets/art/weapons/"
var _textures = {
	Wpn.Bolter: load(_image_dir + "rifle/bolter.png"),
	Wpn.PlasmaRifle: load(_image_dir + "rifle/plasma_rifle_a1.png"),
	Wpn.PistolA:load(_image_dir + "pistol/pistol_a.png"),
	Wpn.PistolB: load(_image_dir + "pistol/pistol_b.png"),
	Wpn.SmgA: load(_image_dir + "smg/smg_a1.png"),
	Wpn.SmgB: load(_image_dir + "smg/smg_b1.png"),
	Wpn.AlienSmgA: load(_image_dir + "smg/alien_smg_a.png"),
	Wpn.AlienSmgB: load(_image_dir + "smg/alien_smg_b.png"),
	Wpn.AlienSmgC: load(_image_dir + "smg/alien_smg_c.png"),
	Wpn.PulseRifle: load(_image_dir + "rifle/pulse_rifle.png"),
	Wpn.CombatShotgun: load(_image_dir + "shotgun/shotgun_a.png"),
	Wpn.AK47: load(_image_dir + "rifle/ak47_a.png"),
	Wpn.FlameThrower: load(_image_dir + "special/flamer_a1.png"),
	Wpn.MeltaGun: load(_image_dir + "special/meltagun.png"),
	Wpn.PlasmaCannon: load(_image_dir + "heavy/plasma_cannon_1.png"),
	Wpn.Axe: load(_image_dir + "melee/axe.png")
}
var _damage = {
	Wpn.Bolter: 10,
	Wpn.PistolA: 5,
	Wpn.PistolB: 6,
	Wpn.SmgA: 5,
	Wpn.SmgB: 6,
	Wpn.CombatShotgun: 3,
	Wpn.Axe: 6
}

var _n_shots = {
	Wpn.CombatShotgun: 6
}

var min_spread = {
	Wpn.Bolter: 1.2,
	Wpn.PlasmaRifle: 1.5,
	Wpn.PistolA: 0.9,
	Wpn.PistolB: 1.1,
	Wpn.SmgA: 2.1,
	Wpn.SmgB: 2.2,
	Wpn.AlienSmgA: 2.2,
	Wpn.AlienSmgB: 2.4,
	Wpn.AlienSmgC: 2.1,
	Wpn.PulseRifle: 1.3,
	Wpn.CombatShotgun: 2.5,
	Wpn.AK47: 1.4,
	Wpn.FlameThrower: 2.0,
	Wpn.MeltaGun: 2.2,
	Wpn.PlasmaCannon: 1.9,
	Wpn.Axe: -1}

var max_spread = {
	Wpn.Bolter: 3.0,
	Wpn.PlasmaRifle: 2.5,
	Wpn.PistolA: 2.2,
	Wpn.PistolB: 2.3,
	Wpn.SmgA: 3.0,
	Wpn.SmgB: 3.4,
	Wpn.AlienSmgA: 3.3,
	Wpn.AlienSmgB: 3.9,
	Wpn.AlienSmgC: 2.6,
	Wpn.PulseRifle: 2.6,
	Wpn.CombatShotgun: 3.2,
	Wpn.AK47: 2.4,
	Wpn.FlameThrower: 2.0,
	Wpn.MeltaGun: 2.4,
	Wpn.PlasmaCannon: 2.9,
	Wpn.Axe: -1
}

var spread_size = {
	Wpn.Bolter: 2,
	Wpn.PlasmaRifle: 2.5,
	Wpn.PistolA: 0.2,
	Wpn.PistolB: 1.1,
	Wpn.SmgA: 2.3,
	Wpn.SmgB: 2.7,
	Wpn.AlienSmgA: 2.2,
	Wpn.AlienSmgB: 2.4,
	Wpn.AlienSmgC: 3.1,
	Wpn.PulseRifle: 1.3,
	Wpn.CombatShotgun: 3.2,
	Wpn.AK47: 0.4,
	Wpn.FlameThrower: 2.0,
	Wpn.MeltaGun: 2.4,
	Wpn.PlasmaCannon: 1.9,
	Wpn.Axe: -1
}

var _projectile_type = {
	Wpn.Bolter: Projectiles.Prj.BolterShell,
	Wpn.PlasmaRifle: Projectiles.Prj.PlasmaBolt,
	Wpn.AlienSmgA: Projectiles.Prj.PulseBurst,
	Wpn.AlienSmgB: Projectiles.Prj.PulseBurst,
	Wpn.AlienSmgC: Projectiles.Prj.PlasmaBolt,
	Wpn.PulseRifle: Projectiles.Prj.PulseBurst,
	Wpn.FlameThrower: Projectiles.Prj.Flame,
	Wpn.PlasmaCannon: Projectiles.Prj.PlasmaBolt
}

var _animation_strings = {
	WeaponTypes.Melee: "melee",
	WeaponTypes.Thrown: "melee",
	WeaponTypes.Pistol: "pistol",
	WeaponTypes.Rifle: "assault_rifle",
	WeaponTypes.SMG: "smg",
	WeaponTypes.Shotgun: "shotgun",
	WeaponTypes.Special: "shotgun",
	WeaponTypes.Heavy: "shotgun"
}

var _continuous_fire = {
	Wpn.PistolA: Munition.Hitscan,
	Wpn.PistolB: Munition.Hitscan,
	Wpn.CombatShotgun: Munition.Hitscan,
	Wpn.PlasmaCannon: Munition.Projectile
}

var _attack_speed = {
	Wpn.Axe: 0.15
}

func get_animation_prefix_string(weapon):
	return _animation_strings[get_weapon_type(weapon)]

func get_stringname(weapon):
	return _weapon_names[weapon]

func get_spread_offset(weapon):
	# returns a randomized spread value for inaccurate weapons like shotgun or SMG
	var angle_chosen = false
	var x_offset
	var y_offset
	while !angle_chosen:
		x_offset = Tools.rng.randf_range(-min_spread[weapon], min_spread[weapon])
		y_offset = Tools.rng.randf_range(-min_spread[weapon], min_spread[weapon])
		if Vector2(x_offset, y_offset).length() <= spread_size[weapon]:
			angle_chosen = true
	var angular_offset = Vector2(x_offset, y_offset)
	var spread_x = deg2rad(angular_offset.x)
	var spread_y = deg2rad(angular_offset.y)
	return Vector2(spread_x, spread_y)

func get_munition_type(weapon):
	return _munition_type[weapon]

func get_weapon_type(weapon):
	return _types[weapon]

func get_projectile(weapon):
	if !_projectile_type.has(weapon):
		return null
	return _projectile_type[weapon]

func get_clip_size(weapon):
	return _clip_size[weapon]

func is_continuous_fire(weapon):
	if _continuous_fire.has(weapon):
		return false
	return true

func get_n_shots(weapon) -> int:
	if _n_shots.has(weapon):
		return _n_shots[weapon]
	return 1

func get_attack_speed(weapon):
	if _attack_speed.has(weapon):
		return _attack_speed[weapon]
	return 0.5
func get_damage(weapon):
	if _damage.has(weapon):
		return _damage[weapon]
	return null

func get_texture(weapon):
	return _textures[weapon].duplicate()

func get_fire_sound(weapon):
	return Tools.r_choice(Sounds.sound_lib["fire"][weapon])

func get_swing_sound(weapon):
	return Tools.r_choice(Sounds.sound_lib["swing"][weapon])

func get_impact_sound(weapon):
	return Tools.r_choice(Sounds.sound_lib["impact"][weapon])
