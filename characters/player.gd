extends CharacterBody3D

signal weapon_fired

@onready var gun_animator = $Camera3D/gun/AnimationPlayer
@onready var raycast_3d = $RayCast3D
@onready var use_raycast = $UseRayCast
@onready var health_label = $HUD/health
@onready var energy_label = $HUD/energy
@onready var flasher = $CanvasLayer/AnimationPlayer
@onready var camera_animator = $Camera3D/AnimationPlayer

@export var impact_effect: PackedScene = preload("res://effects/bullet_impact.tscn")
@export var blood_spurt_effect: PackedScene = preload("res://effects/blood_spurt.tscn")

@export var current_health = 4
@export var current_energy = 0

var current_weapon_damage = 1 # todo get this from current weapon

const SPEED = 3.0
const MOUSE_SENSITIVITY = 0.4

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	gun_animator.play("idle")
	gun_animator.animation_set_next("shoot", "idle")

	
func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * MOUSE_SENSITIVITY

func _process(delta):
	
		
	if Input.is_action_just_pressed("exit"):
		get_tree().quit() # show menu
	if Input.is_action_just_pressed("shoot"):
		if !is_alive():
			get_tree().reload_current_scene()
		else:
			shoot()
	if Input.is_action_just_pressed("use"):
		if !is_alive():
			get_tree().reload_current_scene()
		else:
			use()
	if is_alive():
		health_label.text = "%s" % current_health 
		energy_label.text = "%s" % current_energy

func _physics_process(delta: float) -> void:
	if !is_alive():
		return
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func use():
	if use_raycast.is_colliding() and use_raycast.get_collider().has_method("get_used"):
		if global_position.distance_squared_to(use_raycast.get_collision_point()) < 1:
			use_raycast.get_collider().get_used()
	

func shoot():
	weapon_fired.emit()
	gun_animator.play("shoot")
	gun_animator.seek(0)
	# create bullet
	var hit_obj = false
	if raycast_3d.is_colliding() and raycast_3d.get_collider().has_method("take_damage"):
		raycast_3d.get_collider().take_damage(current_weapon_damage)
		hit_obj = true
	
	var hit_point = raycast_3d.get_collision_point()
	var hit_normal = raycast_3d.get_collision_normal()
	var effect_instance: Node
	if hit_obj:
		effect_instance = blood_spurt_effect.instantiate()
	else:
		effect_instance = impact_effect.instantiate()
	get_tree().current_scene.add_child(effect_instance)
	effect_instance.global_position = hit_point + (hit_normal * 0.1)
	

func collect_item(name: String):
	if name =="orb":
		current_energy += 1
		flasher.play("energy_flash")
	if name == "health":
		current_health += 1
		flasher.play("health_flash")

func take_damage(amount: int):
	if !is_alive():
		return
	current_health -= amount
	flasher.play("hurt_flash")
	if current_health < 0:
		camera_animator.play("collapse")
		flasher.play("dead_flash")
		gun_animator.play("dead")
		gun_animator.seek(0)
	
func is_alive():
	return current_health >= 0
	
