extends Node
var sound_dir = "res://Assets/sound/"
onready var sound_lib = {
	"fire" : {
		Weapons.Wpn.Bolter: 
			[load(sound_dir + "weapons/bolter/fire/st_kinetic_1.ogg"),
			 load(sound_dir + "weapons/bolter/fire/st_kinetic_2.ogg"),
			 load(sound_dir + "weapons/bolter/fire/st_kinetic_3.ogg")],
		Weapons.Wpn.PlasmaRifle: 
			[load(sound_dir + "weapons/plasma_rifle/fire/plasma_fire_02.ogg"),
			 load(sound_dir + "weapons/plasma_rifle/fire/plasma_fire_03.ogg"),
			 load(sound_dir + "weapons/plasma_rifle/fire/plasma_fire_04.ogg")],
		Weapons.Wpn.PistolA: 
			[load(sound_dir + "weapons/pistol/fire/light-gunshot-1.ogg"),
			 load(sound_dir + "weapons/pistol/fire/light-gunshot-2.ogg"),
			 load(sound_dir + "weapons/pistol/fire/light-gunshot-3.ogg"),
			 load(sound_dir + "weapons/pistol/fire/light-gunshot-4.ogg"),
			 load(sound_dir + "weapons/pistol/fire/light-gunshot-5.ogg")],
		Weapons.Wpn.PistolB: 
			[load(sound_dir + "weapons/pistol/fire/minigun.ogg"),
			 load(sound_dir + "weapons/pistol/fire/minigun2.ogg"),
			 load(sound_dir + "weapons/pistol/fire/minigun3.ogg")],
		Weapons.Wpn.SmgA: 
			[load(sound_dir + "weapons/pistol/fire/pistol.ogg"),
			 load(sound_dir + "weapons/pistol/fire/pistol2.ogg"),
			 load(sound_dir + "weapons/pistol/fire/pistol3.ogg")],
		Weapons.Wpn.SmgB: 
			[load(sound_dir + "weapons/pistol/fire/minigun.ogg"),
			 load(sound_dir + "weapons/pistol/fire/minigun2.ogg"),
			 load(sound_dir + "weapons/pistol/fire/minigun3.ogg")],
		Weapons.Wpn.AlienSmgA: 
			[load(sound_dir + "weapons/pistol/fire/minigun.ogg"),
			 load(sound_dir + "weapons/pistol/fire/minigun2.ogg"),
			 load(sound_dir + "weapons/pistol/fire/minigun3.ogg")],
		Weapons.Wpn.AlienSmgB: 
			[load(sound_dir + "weapons/pistol/fire/minigun.ogg"),
			 load(sound_dir + "weapons/pistol/fire/minigun2.ogg"),
			 load(sound_dir + "weapons/pistol/fire/minigun3.ogg")],
		Weapons.Wpn.AlienSmgC: 
			[load(sound_dir + "weapons/pistol/fire/minigun.ogg"),
			 load(sound_dir + "weapons/pistol/fire/minigun2.ogg"),
			 load(sound_dir + "weapons/pistol/fire/minigun3.ogg")],
		Weapons.Wpn.PulseRifle: 
			[load(sound_dir + "weapons/pulse_rifle/fire/Futuristic Assault Rifle Single Shot 01.wav"),
			 load(sound_dir + "weapons/pulse_rifle/fire/Futuristic Assault Rifle Single Shot 02.wav")],
		Weapons.Wpn.CombatShotgun: 
			[load(sound_dir + "weapons/shotgun/fire/shotgun.ogg"),
			 load(sound_dir + "weapons/shotgun/fire/shotgun2.ogg"),
			 load(sound_dir + "weapons/shotgun/fire/shotgun3.ogg")],
		Weapons.Wpn.AK47: 
			[load(sound_dir + "weapons/machinegun/fire/gun-turret-gunshot-01.ogg"),
			 load(sound_dir + "weapons/machinegun/fire/gun-turret-gunshot-02.ogg"),
			 load(sound_dir + "weapons/machinegun/fire/gun-turret-gunshot-03.ogg"),
			 load(sound_dir + "weapons/machinegun/fire/gun-turret-gunshot-04.ogg")],
		Weapons.Wpn.FlameThrower: 
			[load(sound_dir + "weapons/flamethrower/fire/flamethrower-mid.ogg")],
		Weapons.Wpn.MeltaGun:
			[load(sound_dir + "weapons/flamethrower/fire/flamethrower-mid.ogg")],
		Weapons.Wpn.PlasmaCannon: 
			[load(sound_dir + "weapons/assault_rifle/fire/rifle.ogg"),
			 load(sound_dir + "weapons/assault_rifle/fire/rifle2.ogg"),
			 load(sound_dir + "weapons/assault_rifle/fire/rifle3.ogg")]
		},
	"swing": {
		Weapons.Wpn.Axe: 
			[load(sound_dir + "weapons/axe/swish_1.ogg"),
			 load(sound_dir + "weapons/axe/swish_2.ogg"),
			 load(sound_dir + "weapons/axe/swish_3.ogg")]
		},
	"impact": {
		Weapons.Wpn.Axe: 
			[load(sound_dir + "impacts/car-stone-impact-2.ogg"),
			 load(sound_dir + "impacts/car-stone-impact-3.ogg"),
			 load(sound_dir + "impacts/car-stone-impact-4.ogg")]
		},
	"pickup": {
		"corn": $SoundPlayers/DropPickup
		}
	}
