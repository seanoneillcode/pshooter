extends CharacterBody3D

@onready var animated_sprite_2d = $CanvasLayer/gunbase/AnimatedSprite2D

const SPEED = 3.0
const MOUSE_SENSITIVITY = 0.3
var can_shoot = true

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	animated_sprite_2d.animation_finished.connect(shoot_anim_done)
	
func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * MOUSE_SENSITIVITY

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta: float) -> void:

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func shoot():
	if !can_shoot:
		return
	can_shoot = false
	animated_sprite_2d.play("shoot")
	# create bullet
	pass

func shoot_anim_done():
	can_shoot = true
	
	
	
	
