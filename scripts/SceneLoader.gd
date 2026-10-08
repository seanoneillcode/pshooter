extends Node

signal load_finished

var loaded_resource: PackedScene = null
var scene_path: String

var use_sub_threads: bool = true # dubious
var progress: Array = []
var hook_node: Node3D = null

func _ready():
	set_process(false)

func set_hook(_hook_node: Node3D):
	hook_node = _hook_node

func load_scene(_scene_path):
	scene_path = _scene_path
	start_load()	

func start_load():
	var state = ResourceLoader.load_threaded_request(scene_path, "", use_sub_threads)
	if state == OK:
		set_process(true)

func _process(_delta: float) -> void:
	var load_Status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	match load_Status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED:
			loaded_resource = ResourceLoader.load_threaded_get(scene_path)
			
			#var new_level_instance = loaded_resource.instantiate()
			#hook_node.add_child(new_level_instance)
			load_finished.emit()

func actual_change_tree():
	if loaded_resource != null:
		get_tree().change_scene_to_packed(loaded_resource)
