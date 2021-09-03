extends Spatial

const DAMAGE = 10

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

	new_projectile.global_transform = self.global_transform
	# clone.scale = Vector3(4, 4, 4)
	new_projectile.DAMAGE = DAMAGE
