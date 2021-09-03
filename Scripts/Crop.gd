extends StaticBody
signal new_drop
signal killed
onready var drop_type = 0
onready var hitpoints = 1
onready var growth_stage = 0

func _ready():
	$Sprite3D.region_rect.x += 48
	$GrowthTimer.start(Tools.rng.randf_range(3.5, 4.5))


func take_damage(damage_amount):
	kill()

func kill():
	if growth_stage == 3:
		drop()
	queue_free()
	emit_signal("killed")
	remove_from_group("crops")

func drop():
	emit_signal("new_drop", drop_type)


func _on_GrowthTimer_timeout():
	growth_stage += 1
	if growth_stage < 3:
		$GrowthTimer.start(Tools.rng.randf_range(3.5, 4.5))
	$Sprite3D.region_rect.x -= 16
