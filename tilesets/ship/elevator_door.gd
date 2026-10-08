extends Node3D

@onready var animation_player = $door_model/AnimationPlayer
@onready var collision_shape = $physical_door/stop_movement

@export var is_open = false
@export var is_locked = false

var busy_changing_state = false

func _ready() -> void:
	animation_player.play("close")
	animation_player.seek(0.5)

func open():
	is_open = true
	animation_player.play("open")
	collision_shape.disabled = true

func close():
	is_open = false
	animation_player.play("close")
	collision_shape.disabled = false

func get_used():
	if animation_player.is_playing():
		return
	if is_locked:
		return
	is_open = !is_open
	if is_open:
		animation_player.play("open")
		collision_shape.disabled = true
	else:
		animation_player.play("close")
		collision_shape.disabled = false

func lock():
	is_locked = true

func unlock():
	is_locked = false
