extends CollisionShape

func action():
	GameController.pause_player(true)
	
	GameController.control.get_parent().get_node("ComputerScreen").visible = true


func _on_InteractionArea_player_interacting():
	action()
