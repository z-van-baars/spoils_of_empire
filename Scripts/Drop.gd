extends RigidBody

signal pickup
var player

func _ready():
	player = get_tree().root.get_node("World").player
	self.connect("pickup", player, "_on_Drop_pickup")


func setup(item_stats):
	pass


func pickup():
	emit_signal("pickup", self)
	kill()

func kill():
	queue_free()
	remove_from_group("drops")

func get_drop_name():
	return "corn"

func _on_PickupArea_area_entered(area):
	pass


func _on_PickupArea_body_entered(body):
	if body != player:
		return
	pickup()
