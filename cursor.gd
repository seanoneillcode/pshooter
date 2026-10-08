extends AnimatedSprite2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position = get_global_mouse_position()

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		play("click")
	else:
		play("default")
