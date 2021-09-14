extends CollisionShape


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func action():
	var dialogManager = get_parent().get_node("DialogManager")
	GameController.start_dialog(dialogManager)


func _on_InteractionArea_player_interacting():
	action()
