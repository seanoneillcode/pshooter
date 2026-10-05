extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func start():
	for parent in get_children():
		for child in parent.get_children():
			if child.has_method("play"):
				child.play("default")

func stop():
	for parent in get_children():
		for child in parent.get_children():
			if child.has_method("stop"):
				child.stop()
