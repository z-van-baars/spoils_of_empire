extends Spatial

var weapon_type = null
var damage = null

func load_weapon(new_weapon_type):
	weapon_type = new_weapon_type

var is_weapon_enabled = false

onready var projectile_scn = preload("res://Scenes/Projectile.tscn")
onready var particle_scn = preload("res://Scenes/Particle.tscn")

onready var player = null

func _ready():
	pass

func fire():
	var new_projectile = projectile_scn.instance()
	var world_node = get_tree().root.get_node("World")
	world_node.add_child(new_projectile)
	new_projectile.load_projectile_type(Weapons.get_projectile(weapon_type))
	new_projectile.global_transform = self.global_transform
