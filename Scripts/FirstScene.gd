extends Spatial

var thread


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameController.pause_player(false)
	GameController.levelRoot = self


func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		if (GameController.pause_menue_open):
			GameController.closePauseMenue()
		else:
			GameController.openPauseMenue()



func _on_switchToHollaForest():
	if (GameController.finishedFirstLevel):
		GameController.switchToLevel("HollaForestScene")




func _on_KeyCards_player_interacting():
	GameController.haveKeycardDoorA = true
	GameController.haveKeycardDoorB = true
	GameController.control.showInfo("Schlüsselkarten genommen")
	
	$DozentHaus/KeyCards.visible = false
	$DozentHaus/KeyCards/InteractionArea/CollisionShape.disabled = true


func _on_Key_player_interacting():
	GameController.haveKeyForDoorUpstairs = true
	GameController.control.showInfo("Schlüssel genommen")
	
	$Treppenhaeuser/AusTuerB/Gang_02/Key.visible = false
	$Treppenhaeuser/AusTuerB/Gang_02/Key/InteractionArea/CollisionShape.disabled = true


var endTimer = Timer.new()

func _on_Dozent_solutions_player_interacting():
	GameController.haveKeyForDoorUpstairs = true
	GameController.control.showInfo("Lösungen gestohlen")
	
	add_child(endTimer)
	endTimer.connect("timeout", self, "finishGame")
	
	$EndDarker/AnimationPlayer.play("endDarker")
	
	endTimer.start(5.2)
	
	
	$DozentHaus/Solutions.visible = false
	$DozentHaus/Solutions/InteractionArea/CollisionShape.disabled = true


func finishGame():
	print("Game complete")
	
	GameController.switchToLevel("EndScreen")
