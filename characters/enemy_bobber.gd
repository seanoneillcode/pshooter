extends CharacterBody3D

@onready var animated_Sprite_3d = $AnimatedSprite3D
@onready var raycast_3d = $RayCast3D

@export var move_speed = 3.0
@export var attack_Range = 12.0
@export var range_make_attack = 0.7
@export var health:int = 2
@export var damage_amount: int= 1

@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
@export var orb: PackedScene = preload("res://objects/orb.tscn")

var time_it_takes_to_attack = 0.6
var attack_timer = 0
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
	var move_towards_player = false
	var distance = global_position.distance_to(player.global_position)
	if state == "move":
		move_towards_player = true
		if distance < range_make_attack:
			print_debug("tswitching to attack state")
			state = "attack"
			attack_timer = time_it_takes_to_attack
			animated_Sprite_3d.play("attack")
		else:
			animated_Sprite_3d.play("move")
			
	if state == "attack":
		move_towards_player = true
		attack_timer -= delta
		if attack_timer < 0:
			player.take_damage(damage_amount)
			state = "move"
	
	if move_towards_player and distance > 0.4 and player.is_alive():
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
		# add soul, percentage 
		
		queue_free() # Removes the enemy from the scene tree and deletes it
	
func take_damage(amount: int):
	if dead:
		return
	health = health - amount
	if health == 0:
		dead = true
		state = "die"
		animated_Sprite_3d.play("die")
		$CollisionShape3D.disabled = true
		var orb_instance = orb.instantiate()
		get_tree().current_scene.add_child(orb_instance)
		orb_instance.global_position = global_position
	else:
		state = "hurt"
		animated_Sprite_3d.play("hurt")
	
	
	
