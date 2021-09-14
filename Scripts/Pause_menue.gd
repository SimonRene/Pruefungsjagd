extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
##	if Input.is_action_just_pressed("ui_cancel"):
#	#	closePauseMenue()


func openPauseMenue():
	$CenterContainer.visible = true

func closePauseMenue():
	$CenterContainer.visible = false
	$CenterContainer/AskExitPanel.visible = false
	$CenterContainer/ControlPanel.visible = false

func continueGame():
	GameController.closePauseMenue()

func askExitGame():
	$CenterContainer/AskExitPanel.visible = true

func askExitBack():
	$CenterContainer/AskExitPanel.visible = false

func exitGame():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().quit()


func _on_Button_pressed():
	continueGame()


func _on_Button2_pressed():
	askExitGame()


func _on_ButtonEXIT_pressed():
	exitGame()


func _on_ButtonBack_pressed():
	askExitBack()


func _on_ButtonBackFromControls_pressed():
	print("Back from Controls")
	$CenterContainer/ControlPanel.visible = false


func _on_ButtonControls_pressed():
	$CenterContainer/ControlPanel.visible = true
