extends Spatial


signal lookingAt(at)
signal stoppedLooking


func _ready():
	pass # Replace with function body.


func pickUp():
	print("Added Motorsaw to inventory")
	GameController.foundMotorsaw = true
	$Motorsaw2.visible = false
	GameController.control.hide_interaction()
	GameController.control.showInfo("Motorsäge mit Benzin aufgehoben")
	$AudioStreamPlayer.play()


func _on_InteractionArea_player_interacting():
	if GameController.foundGenerator:
		pickUp()


func _on_InteractionArea_player_looking(at):
	if GameController.foundGenerator:
		emit_signal("lookingAt", at)


func _on_InteractionArea_player_looking_stopped():
	if GameController.foundGenerator:
		emit_signal("stoppedLooking")
