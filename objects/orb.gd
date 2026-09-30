extends Area3D

@onready var animated_sprite = $AnimatedSprite3D
@export var pickup_name = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("default")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if body.has_method("collect_item"):
			body.collect_item(pickup_name)
			queue_free()
