extends AnimatedSprite2D



func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	global_position = get_global_mouse_position()


func _physics_process(delta: float) -> void:
	global_position = get_global_mouse_position()

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		play("click")
	else:
		play("default")
