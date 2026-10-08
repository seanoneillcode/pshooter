extends Node3D

@export var indicators: Node3D
@export var door: Node3D

@export var elevator_menu: PackedScene


func _ready() -> void:
	run_elevator()

func get_used():
	print_debug("got used")
	get_tree().change_scene_to_packed(elevator_menu)

func run_elevator():
	# change lights
	indicators.start()
	door.close()
	door.lock()
	await get_tree().create_timer(2.4).timeout
	indicators.stop()
	door.unlock()
	door.open()
	
