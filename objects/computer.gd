extends Node3D

@export var indicators: Node3D
@export var data_scene: StringName
@export var lab_scene: StringName
@export var dorm_scene: StringName
@export var door: Node3D

@export var gui: Node
@export var player: Node3D


func _ready() -> void:
	pass

func get_used():
	print_debug("got used")
	gui.visible = true
	gui.connect("selected", select_level)
	player.set_process(false)
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func select_level(val: String):
	print_debug("select level")
	match val:
		"data":
			run_elevator(data_scene)
		"dorm":
			run_elevator(dorm_scene)
		"lab":
			run_elevator(lab_scene)

func run_elevator(scene: StringName):
	if scene == null:
		return
	gui.visible = false

	indicators.start()
	door.close()
	SceneLoader.connect("load_finished", switch_level)
	SceneLoader.load_scene(scene)
	

	
	# should close the door first, waiting
	# then change the scene
	# then shake the elevator or move the lights or something
	# then open the door
	
	#player = get_tree().get_first_node_in_group("player")
	#var player_offset = player
	#SceneLoader.load_scene(level_name)
	
func switch_level():
	await get_tree().create_timer(4.0).timeout
	indicators.stop()
	SceneLoader.actual_change_tree()



# how about, open elevator door -> loads elevator mini level?
