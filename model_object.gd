extends MeshInstance3D

var defaultMaterial = null
@export var highlightMat: StandardMaterial3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	defaultMaterial = get_active_material(0)

func _on_selection_btn_mouse_entered() -> void:
	self.set_surface_override_material(0, highlightMat)

func _on_selection_btn_mouse_exited() -> void:
	self.set_surface_override_material(0, defaultMaterial)
