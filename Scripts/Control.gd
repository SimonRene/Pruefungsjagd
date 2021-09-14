extends Control


var currentDialogManager

var thread

var timer

func _ready():
	GameController.setControl(self)
	$Timer.connect("timeout", self, "hideInfo")


func show_interaction(displayText):
	$InteractionLabel.text = displayText
	$InteractionLabel.visible = true


func hide_interaction():
	$InteractionLabel.visible = false


func showLoading():
	print("show Loading...")
	$LoadingInfo.visible = true


func execute_action(name):
	print("executing action: ", name)
	
	match (name):
		"makeRed":
			print("make it red!")
			
		"makeYellow":
			print("make it yellow!")
			


func process_dialog_speech(dialogNode):
	
	# execute action
	if (dialogNode.size() > 1):
		GameController.execute_dialog_action(dialogNode[1])
	
	$SpeechPanel/Label.text = dialogNode[0]
	$ChoicePanel/Label.text = dialogNode[0]
	$SpeechPanel.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func process_dialog_choice(dialogNode):
	if (len(dialogNode) >= 1):
		$ChoicePanel/Button.text = dialogNode[0]
		$ChoicePanel/Button.visible = true
	if (len(dialogNode) >= 2):
		$ChoicePanel/Button2.text = dialogNode[1]
		$ChoicePanel/Button2.visible = true
	if (len(dialogNode) >= 3):
		$ChoicePanel/Button3.text = dialogNode[2]
		$ChoicePanel/Button3.visible = true
	$ChoicePanel.visible = true
	print(dialogNode)
		

func setDialogManager(dialogManager):
	currentDialogManager = dialogManager
	

func setDialogName(name):
	$NamePanel/Label.text = name
	$NamePanel.visible = true

func dialog_finished():
	$SpeechPanel.visible = false
	$ChoicePanel.visible = false
	$NamePanel.visible = false

func continue_dialog():
	if (currentDialogManager):
		currentDialogManager.continue_dialog()


func showInfo(info):
	$InfoPanel/InfoLabel.text = info
	$InfoPanel.visible = true
	$Timer.start(2.0)


func hideInfo():
	$InfoPanel.visible = false


func switchToLevel(name):
	showLoading()
	GameController.player.levelEnded = true
	GameController.pause_player(true)
	thread = Thread.new()
	thread.start(self, "switchToOtherLevel", name, 2)


func switchToOtherLevel(levelName):
	print("in other thread: switch to level " + levelName)
	var pathToScene = "res://Scene/" + levelName + ".tscn"
	get_tree().change_scene(pathToScene)


func _exit_tree():
	if thread != null:
		thread.wait_to_finish()


# Signals Slots

func _on_DialogManager_new_speech(speech_codes):
	process_dialog_speech(speech_codes)


func _on_speech_next_pressed():
	$SpeechPanel.visible = false
	continue_dialog()


func _on_DialogManager_new_choice(choices):
	process_dialog_choice(choices)


func _on_choice_1_pressed():
	$ChoicePanel.visible = false
	$ChoicePanel/Button.visible = false
	$ChoicePanel/Button2.visible = false
	$ChoicePanel/Button3.visible = false
	currentDialogManager.choice_picked(0)


func _on_choice_2_pressed():
	$ChoicePanel.visible = false
	$ChoicePanel/Button.visible = false
	$ChoicePanel/Button2.visible = false
	$ChoicePanel/Button3.visible = false
	currentDialogManager.choice_picked(1)


func _on_choice_3_pressed():
	$ChoicePanel.visible = false
	$ChoicePanel/Button.visible = false
	$ChoicePanel/Button2.visible = false
	$ChoicePanel/Button3.visible = false
	currentDialogManager.choice_picked(2)


func _on_DialogManager_dialog_finished():
	GameController.stop_dialog()


func _on_DialogManager_dialog_started(name):
	setDialogName(name)


func _on_InteractionArea_player_looking(at):
	show_interaction(at)


func _on_InteractionArea_player_looking_stopped():
	hide_interaction()


func _on_DozentHaus_needKey():
	showInfo("Schlüssel benötigt")


func _on_DozentHaus_needKeyCard():
	showInfo("Schlüsselkarte benötigt")
