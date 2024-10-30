extends Node

@export var grating1: TextureRect;
@export var grating2: TextureRect;

var materials1 = {};
var materials2 = {};

# Called when the node enters the scene tree for the first time.
func _enter_tree() -> void:
	materials1['Concentric'] = load("res://Materials/Concentric.tres").duplicate();
	materials1['Linear'] = load("res://Materials/Linear.tres").duplicate();
	materials1['Radial'] = load("res://Materials/Radial.tres").duplicate();

	materials2['Concentric'] = load("res://Materials/Concentric.tres").duplicate();
	materials2['Linear'] = load("res://Materials/Linear.tres").duplicate();
	materials2['Radial'] = load("res://Materials/Radial.tres").duplicate();

	GlobalSignals.Angle1Changed.connect(onAngle1Changed)
	GlobalSignals.Angle2Changed.connect(onAngle2Changed)

	GlobalSignals.Stripes1Changed.connect(onStripes1Changed)
	GlobalSignals.Stripes2Changed.connect(onStripes2Changed)
	
	GlobalSignals.Size1Changed.connect(onSize1Changed)
	GlobalSignals.Size2Changed.connect(onSize2Changed)

	GlobalSignals.Shader1Changed.connect(onShader1Changed)
	GlobalSignals.Shader2Changed.connect(onShader2Changed)

# Angle controls
func onAngle1Changed(angle) -> void:
	updateAngle(grating1, angle)

func onAngle2Changed(angle) -> void:
	updateAngle(grating2, angle)
	
func updateAngle(grating, angle) -> void:
	var sm: ShaderMaterial = grating.material
	sm.set_shader_parameter("ANGLE", angle)

# Stripes controls
func onStripes1Changed(stripes: int) -> void:
	updateStripes(grating1, stripes)

func onStripes2Changed(stripes: int) -> void:
	updateStripes(grating2, stripes)
	
func updateStripes(grating, stripes) -> void:
	var sm: ShaderMaterial = grating.material
	sm.set_shader_parameter("STRIPES", stripes)

# Size controls
func onSize1Changed(size: int) -> void:
	grating1.scale = Vector2(size, size) / grating1.texture.get_size().x
	grating1.pivot_offset = grating1.texture.get_size() / 2

func onSize2Changed(size: int) -> void:
	grating2.scale = Vector2(size, size) / grating2.texture.get_size().x
	grating2.pivot_offset = grating2.texture.get_size() / 2

# Shader controls
func onShader1Changed(shader: String) -> void:
	updateMaterial(grating1, materials1[shader])

func onShader2Changed(shader: String) -> void:
	updateMaterial(grating2, materials2[shader])

func updateMaterial(grating, material: Material) -> void:
	grating.material = material
