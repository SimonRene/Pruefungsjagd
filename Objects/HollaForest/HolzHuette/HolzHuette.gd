extends Spatial

signal isLookingAtDoorHandle(at)
signal stoppedLookingAtDoorHandle

signal interactedWithDoorHandle

var isClosed = true

func openDoor():
	if (isClosed):
		$Tuer2/AnimationPlayer.play(("openDoor"))

func closeDoor():
	if (!isClosed):
		$Tuer2/AnimationPlayer.play(("closeDoor"))


func _on_InteractionArea_player_looking(at):
	at = "Türe öffnen"
	if (!isClosed):
		at = "Türe schließen"
	emit_signal("isLookingAtDoorHandle", at)


func _on_InteractionArea_player_looking_stopped():
	emit_signal("stoppedLookingAtDoorHandle")


func _on_InteractionArea_player_interacting():
	emit_signal("interactedWithDoorHandle")
	
	if (isClosed):
		isClosed = false
		$Tuer2/AnimationPlayer.play("openDoor")
	else:
		isClosed = true
		$Tuer2/AnimationPlayer.play("closeDoor")
