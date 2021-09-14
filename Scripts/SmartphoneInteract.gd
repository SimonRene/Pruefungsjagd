extends CollisionShape


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func action():
	print("Call...")
	GameController.pause_player(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	GameController.get_controlNode().get_parent().get_node("SmartphoneDisplay").visible = true


func _on_InteractionArea_player_interacting():
	action()
