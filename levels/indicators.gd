extends Node3D

	
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
