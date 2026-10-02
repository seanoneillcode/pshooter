extends Node3D

@onready var animation_player = $door_model/AnimationPlayer
@onready var collision_shape = $physical_door/stop_movement

@export var is_open = false

var busy_changing_state = false
@export var next_scene: StringName

func _ready() -> void:
	animation_player.play("close")
	animation_player.seek(0.5)

func get_used():
	if animation_player.is_playing():
		return
	if next_scene != "":
		SceneLoader.load_scene(next_scene) #then open
	is_open = !is_open
	if is_open:
		animation_player.play("open")
		collision_shape.disabled = true
	else:
		animation_player.play("close")
		collision_shape.disabled = false
	
