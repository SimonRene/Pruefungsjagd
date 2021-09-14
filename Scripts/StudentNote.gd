extends MeshInstance


func _ready():
	pass # Replace with function body.


func inspect():
	GameController.inspectItem(self)
	get_parent().visible = false


func _on_InteractionArea_player_interacting():
	inspect()
