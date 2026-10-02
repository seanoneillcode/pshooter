extends Node3D

@export var level_name: StringName = &""

func _ready() -> void:
	pass

func get_used():
	# should close the door first, waiting
	# then change the scene
	# then shake the elevator or move the lights or something
	# then open the door
	
	#player = get_tree().get_first_node_in_group("player")
	#var player_offset = player
	SceneLoader.load_scene(level_name)
	



# how about, open elevator door -> loads elevator mini level?
