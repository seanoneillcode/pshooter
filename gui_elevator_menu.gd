extends Control

signal selected


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_data_selection_btn_pressed() -> void:
	print_debug("pressed a")
	emit_signal("selected", "data")


func _on_dorm_selection_btn_pressed() -> void:
	print_debug("pressed b")
	emit_signal("selected", "dorm")


func _on_lab_selection_btn_pressed() -> void:
	print_debug("pressed c")
	emit_signal("selected", "lab")
