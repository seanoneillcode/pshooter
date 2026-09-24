extends CharacterBody3D

@onready var animation_player = $gun/AnimationPlayer
@onready var raycast_3d = $RayCast3D

const SPEED = 3.0
const MOUSE_SENSITIVITY = 0.4

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	animation_player.play("idle")
	animation_player.animation_set_next("shoot", "idle")

	
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
	animation_player.play("shoot")
	animation_player.seek(0)
	# create bullet
	if raycast_3d.is_colliding() and raycast_3d.get_collider().has_method("get_hurt"):
		raycast_3d.get_collider().get_hurt()

	
	
	
	
