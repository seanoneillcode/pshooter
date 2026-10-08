extends Control


@export var data_scene: StringName
@export var lab_scene: StringName
@export var dorm_scene: StringName

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	SceneLoader.connect("load_finished", switch_level)

func switch_level():
	SceneLoader.actual_change_tree()

func _on_data_selection_btn_pressed() -> void:
	SceneLoader.load_scene(data_scene)

func _on_dorm_selection_btn_pressed() -> void:
	SceneLoader.load_scene(dorm_scene)

func _on_lab_selection_btn_pressed() -> void:
	SceneLoader.load_scene(lab_scene)
