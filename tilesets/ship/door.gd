extends Node3D

@onready var animation_player = $door_model/AnimationPlayer
@onready var collision_shape = $physical_door/stop_movement

@export var is_open = false
@export var is_locked = false

var busy_changing_state = false
var timer = Timer.new()

func _ready() -> void:
	animation_player.play("close")
	animation_player.seek(0.5)
	timer.wait_time = 6
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(close)

func close():
	is_open = false
	animation_player.play("close")
	collision_shape.disabled = false
	

func open():
	is_open = true
	animation_player.play("open")
	collision_shape.disabled = true
	timer.start()
	
func lock():
	is_locked = true

func unlock():
	is_locked = false

func get_used():
	if animation_player.is_playing():
		return
	if is_locked:
		return # play locked sound
	is_open = !is_open
	if is_open:
		open()
	else:
		close()
	
