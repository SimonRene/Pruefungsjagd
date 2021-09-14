extends Spatial



signal lookedAtStartButton(at)
signal lookedAtBenzin(at)
signal stoppedLookingStartButton
signal stoppedLookingBenzin

var hasFuel= false
var running = false


func fillFuel():
	if (!GameController.foundArcade):
		return
	
	if GameController.foundMotorsaw:
		print("Refilled Generator")
		hasFuel = true
		QuestLog.finish_a_quest(40)
		QuestLog.finish_a_quest(50)
		$fillAudio.play()
	else:
		GameController.control.showInfo("Du hast kein Benzin")

func pressStartButton():
	if (!GameController.foundArcade):
		return
	
	if !GameController.foundGenerator:
		QuestLog.add_quest(50)
		GameController.foundGenerator = true
	
	if hasFuel:
		print("Generator started")
		startGenerator()
	else:
		GameController.control.showInfo("Der Generator hat kein Benzin")
		
		
func startGenerator():
	# TODO: play motor sound ...
	running = true
	GameController.generatorRunning = true
	$startGeneratorAudio.play()
	$fillAudio.stop()


func _on_startButton_interacting():
	if (!GameController.foundArcade):
		return
	pressStartButton()


func _on_fuel_refill_interacting():
	if (!GameController.foundArcade):
		return
	fillFuel()


func _on_InteractionArea_player_looking(at):
	if (!GameController.foundArcade):
		return
	emit_signal("lookedAtStartButton", at)


func _on_InteractionArea_player_looking_stopped():
	if (!GameController.foundArcade):
		return
	emit_signal("stoppedLookingStartButton")
	


func _on_InteractionArea2_player_looking(at):
	if (!GameController.foundArcade):
		return
	emit_signal("lookedAtBenzin",at)


func _on_InteractionArea2_player_looking_stopped():
	if (!GameController.foundArcade):
		return
	emit_signal("stoppedLookingBenzin")
