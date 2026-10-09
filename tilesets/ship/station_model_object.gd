extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var material = SpatialMaterial.new()
	var material = $MeshInstance.get_surface_material(0)
	material.albedo_color = Color(0.224, 0.482, 0.267, 1.0)
	$MeshInstance.set_surface_material(0, material)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
