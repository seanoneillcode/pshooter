extends AnimatedSprite3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("default")
	animation_finished.connect(_finished)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _finished():
	queue_free()
