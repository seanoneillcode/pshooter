extends Node3D

@onready var muzzle_effect = $GPUParticles3D
@onready var muzzle_light = $OmniLight3D
@onready var player = $"../../.."

@onready var spinner_light = $"../root/hold/spinner/AnimationPlayer"

func _ready() -> void:
	player.weapon_fired.connect(add_muzzle_flash)

func add_muzzle_flash():
	muzzle_light.visible = true
	muzzle_effect.emitting = true
	spinner_light.play("dim")
	await  get_tree().create_timer(0.05).timeout
	muzzle_light.visible = false
	muzzle_effect.emitting = false
	
