extends Spatial

var doorOpen = false

func openDoor():
	$AnimationPlayer.play("OpenDoor")
	doorOpen = true
	$InteractionArea.interactionText = "schließe Tür"
	

func closeDoor():
	$AnimationPlayer.play("CloseDoor02")
	doorOpen = false
	$InteractionArea.interactionText = "öffne Tür"

func _on_InteractionArea_player_interacting():
	if (doorOpen):
		closeDoor()
	else:
		openDoor()
