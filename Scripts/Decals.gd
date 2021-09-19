extends Node

enum Dcl {
	BulletHole
	}

var decal_names = {
	Dcl.BulletHole: "bullet_hole"
	}

var directory_string = "res://Assets/art/particles/"
var image_files = {
	Dcl.BulletHole: [
		load(directory_string + "/gray_point_1.png"),
		load(directory_string + "/gray_point_2.png"),
		load(directory_string + "/gray_point_3.png"),
		load(directory_string + "/gray_point_4.png")]
	}

var modulation = {
	Dcl.BulletHole: Color.darkgray
	}


func get_texture(decal_type):
	return Tools.r_choice(image_files[decal_type]).duplicate()

func get_modulation(decal_type):
	if modulation.has(decal_type):
		return modulation[decal_type]
	return Color.white
