extends Node

@export var angle1Input: SpinBox;
@export var angle2Input: SpinBox;
@export var angleLockInput: CheckBox;

@export var stripes1Input: SpinBox;
@export var stripes2Input: SpinBox;
@export var stripesLockInput: CheckBox;

@export var shader1Input: OptionButton;
@export var shader2Input: OptionButton;

@export var size1Input: SpinBox;
@export var size2Input: SpinBox;
@export var sizeLockInput: CheckBox;

# Called when the node enters the scene tree for the first time.
func _enter_tree() -> void:
	angle1Input.value_changed.connect(onAngle1Changed)
	angle2Input.value_changed.connect(onAngle2Changed)
	angleLockInput.toggled.connect(onAngleLockChanged)
	
	stripes1Input.value_changed.connect(onStripes1Changed)
	stripes2Input.value_changed.connect(onStripes2Changed)
	stripesLockInput.toggled.connect(onStripesLockChanged)
	
	size1Input.value_changed.connect(onSize1Changed)
	size2Input.value_changed.connect(onSize2Changed)
	sizeLockInput.toggled.connect(onSizeLockChanged)
	
	shader1Input.item_selected.connect(onShader1Changed)
	shader2Input.item_selected.connect(onShader2Changed)

func _ready():
	shader1Input.select(0)
	shader2Input.select(0)
	onShader1Changed(0)
	onShader2Changed(0)
	
# Initialize all controls
func initialize1Controls():
	onAngle1Changed(angle1Input.value)
	onStripes1Changed(stripes1Input.value)
	onSize1Changed(size1Input.value)
	pass

func initialize2Controls():
	onAngle2Changed(angle2Input.value)
	onStripes2Changed(stripes2Input.value)
	onSize2Changed(size2Input.value)

# Angle controls
func onAngle1Changed(angle: float) -> void:
	GlobalSignals.Angle1Changed.emit(angle)
	if angleLockInput.button_pressed:
		GlobalSignals.Angle2Changed.emit(angle)

func onAngle2Changed(angle: float) -> void:
	if not angleLockInput.button_pressed:
		GlobalSignals.Angle2Changed.emit(angle)
	
func onAngleLockChanged(toggledOn: bool) -> void:
	if toggledOn:
		GlobalSignals.Angle2Changed.emit(angle1Input.value)
	else:
		GlobalSignals.Angle2Changed.emit(angle2Input.value)

# Stripes controls
func onStripes1Changed(stripes: int) -> void:
	GlobalSignals.Stripes1Changed.emit(stripes)
	if stripesLockInput.button_pressed:
		GlobalSignals.Stripes2Changed.emit(stripes)

func onStripes2Changed(stripes: int) -> void:
	if not stripesLockInput.button_pressed:
		GlobalSignals.Stripes2Changed.emit(stripes)

func onStripesLockChanged(toggledOn: bool) -> void:
	if toggledOn:
		GlobalSignals.Stripes2Changed.emit(stripes1Input.value)
	else:
		GlobalSignals.Stripes2Changed.emit(stripes2Input.value)

# Size controls
func onSize1Changed(size: int) -> void:
	GlobalSignals.Size1Changed.emit(size)
	if sizeLockInput.button_pressed:
		GlobalSignals.Size2Changed.emit(size)

func onSize2Changed(size: int) -> void:
	if not sizeLockInput.button_pressed:
		GlobalSignals.Size2Changed.emit(size)

func onSizeLockChanged(toggledOn: bool) -> void:
	if toggledOn:
		GlobalSignals.Size2Changed.emit(size1Input.value)
	else:
		GlobalSignals.Size2Changed.emit(size2Input.value)

# Shader controls
func onShader1Changed(index: int) -> void:
	GlobalSignals.Shader1Changed.emit(shader1Input.get_item_text(index))
	initialize1Controls()
	initialize2Controls()

func onShader2Changed(index: int) -> void:
	GlobalSignals.Shader2Changed.emit(shader2Input.get_item_text(index))
	initialize1Controls()
	initialize2Controls()
