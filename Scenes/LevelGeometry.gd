tool
extends MeshInstance

# slider for easily editing the value.
export(float, EXP, 2, 1000, 0.1) var editorWidth setget setWidth
# slider for easily editing the value.
export(float, EXP, 2, 1000, 0.1) var editorHeight setget setHeight

var textures_list = Tools.list_files_in_directory()

var materials_list

export(int, textures_list) var SurfaceTexture setget setTexture
export(int, materials_list) var SurfaceMaterial setget setMaterial




func setWidth(new_width):
	editorWidth = new_width
	change_size()

func setHeight(new_height):
	editorHeight = new_height
	change_size()

func change_size():
	mesh.size.x = editorWidth
	mesh.size.y = editorHeight
	var plane_shape = $StaticBody/CollisionShape.shape
	plane_shape.extents = Vector3(editorWidth / 2, 0.1, editorHeight / 2)

func setTexture(new_texture):
	SurfaceTexture = new_texture

func setMaterial(new_material):
	SurfaceMaterial = new_material
