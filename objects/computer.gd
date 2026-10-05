extends Node3D

@export var indicators: Node3D
@export var next_scene: StringName
@export var door: Node3D

func _ready() -> void:
	pass

func get_used():
	print_debug("got used")
	indicators.start()
	door.close()
		
	SceneLoader.connect("load_finished", donesos)
	SceneLoader.load_scene(next_scene)
	
	# should close the door first, waiting
	# then change the scene
	# then shake the elevator or move the lights or something
	# then open the door
	
	#player = get_tree().get_first_node_in_group("player")
	#var player_offset = player
	#SceneLoader.load_scene(level_name)
func donesos():
	await get_tree().create_timer(4.0).timeout
	indicators.stop()
	SceneLoader.actual_change_tree()



# how about, open elevator door -> loads elevator mini level?
