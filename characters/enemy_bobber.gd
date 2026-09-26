extends CharacterBody3D

@onready var animated_Sprite_3d = $AnimatedSprite3D
@onready var raycast_3d = $RayCast3D

@export var move_speed = 1.4
@export var attack_Range = 12.0
@export var health = 2

@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")

var dead = false
var state = ""

func _ready():
	animated_Sprite_3d.connect("animation_finished", handle_animation_finished)
	animated_Sprite_3d.play("move")
	await get_tree().create_timer(0.1).timeout
	state = "idle"

func _physics_process(delta: float) -> void:
	if dead:
		return
	if player == null:
		return
		
	if state == "idle":
		var distance = global_position.distance_to(player.global_position)
		if distance < attack_Range:
			# point the raycast at the player
			var target_pos: Vector3 = raycast_3d.to_local(player.global_position + Vector3(0,0.5,0))
			raycast_3d.target_position = target_pos
			# Force an immediate physics update for accurate real-time results
			raycast_3d.force_raycast_update()
			if raycast_3d.is_colliding():
				if raycast_3d.get_collider() == player:
					print_debug("enemy has line of sight")
					state = "move"
	
	if state == "move":
		animated_Sprite_3d.play("move")
		var dir = player.global_position - global_position
		dir.y = 0
		dir = dir.normalized()
		velocity = dir * move_speed
		move_and_slide()
	

func handle_animation_finished():
	if state == "hurt":
		state = "idle"
		animated_Sprite_3d.play("move")
	if state == "die":
		queue_free() # Removes the enemy from the scene tree and deletes it
	
func get_hurt():
	if dead:
		return
	health = health - 1
	if health == 0:
		dead = true
		state = "die"
		animated_Sprite_3d.play("die")
		$CollisionShape3D.disabled = true
	else:
		state = "hurt"
		animated_Sprite_3d.play("hurt")
	
	
	
