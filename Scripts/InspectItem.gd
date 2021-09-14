extends MeshInstance


func _ready():
	pass # Replace with function body.


func inspect():
	GameController.inspectItem(self)
	get_parent().visible = false


func _on_InteractionArea_player_interacting():
	inspect()


func mouse_clicked():
	print("clicked")
	var mat = $MeshInstance.get_surface_material(0)
	mat.albedo_color = Color(0.2, 0.4, 0.8)
