tool
extends RigidBody

var sprites = {
	0: load("res://Assets/art/objects/Space Pack/Computer station 1.png"),
	1: load("res://Assets/art/objects/Space Pack/Computer station 2.png"),
	2: load("res://Assets/art/objects/Space Pack/Computer 1.png"),
	3: load("res://Assets/art/objects/Space Pack/Computer 2.png"),
	4: load("res://Assets/art/objects/Space Pack/Baril 1.png"),
	5: load("res://Assets/art/objects/Space Pack/Baril 2.png"),
	6: load("res://Assets/art/objects/Space Pack/Desk 1.png"),
	7: load("res://Assets/art/objects/Space Pack/Machine 1.png"),
	8: load("res://Assets/art/objects/Space Pack/CryoBox.png")
}

var audio_files = {
	0: load("res://Assets/sound/test/boiler.ogg"),
	1: load("res://Assets/sound/test/burner-mining-drill.ogg")
}

# Editor will enumerate as 0, 1 and 2.
export(int, "ComputerStation_1", "ComputerStation_2", "Computer_1", "Computer_2",
	   "Barrel_1", "Barrel_2", "Desk_1", "Machine_1", "CryoBox") var object_type setget setObject

export(bool) var LightSource = false setget setLightSource
export(float, 1, 1000, 0.1) var LightBrightness = 3 setget setLightBrightness
export(float, 1, 1000, 0.1) var LightRadius = 50 setget setLightRadius
export(Color, RGB) var LightColor = Color.white setget setLightColor


export(bool) var EmitSound setget setEmitSound
export(int, "Boiler", "Burner Drill") var SoundEmission setget setSoundEmission
export(float, -80.0, 80.0, 0.5) var SoundLevel = 0 setget setSoundLevel
export(bool) var LoopSound setget setLoopSound


func setObject(new_value):
	object_type = new_value
	$Sprite3D.texture = sprites[object_type]

func setLightSource(new_value):
	LightSource = new_value
	set_light()

func setLightBrightness(new_value):
	LightBrightness = new_value
	set_light()

func setLightRadius(new_value):
	LightRadius = new_value
	set_light()

func setLightColor(new_value):
	LightColor = new_value
	set_light()

func set_light():
	$OmniLight.omni_range = LightRadius
	$OmniLight.light_color = LightColor
	if LightSource == false:
		$OmniLight.light_energy = 0
		$Sprite3D.material_override.emission_enabled = false
	else:
		$OmniLight.light_energy = LightBrightness
		$Sprite3D.material_override.emission_enabled = true
		$Sprite3D.material_override.emission = LightColor
		$Sprite3D.material_override.emission_energy = LightBrightness / 200

func setEmitSound(new_value):
	EmitSound = new_value

func setLoopSound(new_value):
	LoopSound = new_value

func setSoundEmission(new_soundfile):
	SoundEmission = new_soundfile
	$AudioStreamPlayer3D.stream = audio_files[new_soundfile]

func setSoundLevel(new_level):
	SoundLevel = new_level
	$AudioStreamPlayer3D.unit_db = new_level



func _on_AudioStreamPlayer3D_finished():
	if LoopSound:
		$AudioStreamPlayer3D.play()
	else:
		$AudioStreamPlayer3D.stop()
