extends Spatial

var EFFECT_TYPE
var START_LIGHT_INTENSITY

func load_effect_type(effect_type):
	EFFECT_TYPE = effect_type
	add_to_group("effects")
	$OmniLight.omni_range = Effects.get_light_radius(effect_type)
	$OmniLight.light_energy = Effects.get_light_intensity(effect_type)
	START_LIGHT_INTENSITY = Effects.get_light_intensity(effect_type)
	$OmniLight.light_color = Effects.get_light_color(effect_type)
	if effect_type == Effects.Eft.BulletImpact:
		$AnimatedSprite3D.frames.set_animation_speed(Effects.get_animation_name(effect_type), 20)
	$AnimatedSprite3D.play(Effects.get_animation_name(effect_type))
	$Timer.start()

func _process(_delta):
	$OmniLight.light_energy = START_LIGHT_INTENSITY * $Timer.time_left


func _on_AnimatedSprite3D_animation_finished():
	remove_from_group("effects")
	queue_free()



func _on_Timer_timeout():
	remove_from_group("effects")
	queue_free()
