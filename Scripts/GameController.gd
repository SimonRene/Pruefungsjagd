extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var thread

var levelRoot
var player
var control

var dialogActive = false
var inspecting = false


var pause_menue_open = false


#info first level
var finishedFirstLevel = false

# info HollaForest level
var talkedToHolla = false
var foundArcade = false
var foundGenerator = false
var foundMotorsaw = false

var generatorRunning = false

var gotFakeAnswersFromHolla



# Dozent

var haveKeycardDoorA = false
var haveKeycardDoorB = false

var haveKeyForDoorUpstairs = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func setPlayer(_player):
	player = _player

func setControl(_control):
	control = _control

func execute_dialog_action(name):
	print("execute action: ", name)
	
	match (name):
		"makeRed":
			print("Set Color of Wall to Red (Color(1,0,0))")
			get_node("/root/FirstScene/Wall").setColor(Color(1,0,0))
		"makeYellow":
			print("Set Color of Wall to Yellow (Color(1,1,0))")
			get_node("/root/FirstScene/Wall").setColor(Color(1,1,0))
		"talkedToHolla":
			talkedToHolla = true
			print("set condition: talked to Holla")
			QuestLog.finish_a_quest(10)
			get_node("/root/HollaForestScene/ForestLevel/HollaHaus/HollaDieWaldfee/hollaConditions").talked = true
		"addQuestHighscoreForHolla":
			QuestLog.add_quest(30)
			get_node("/root/HollaForestScene/ForestLevel/HollaHaus").closeFrontDoor()
		"HollaCloseDoor":
			get_node("/root/HollaForestScene/ForestLevel/HollaHaus").closeFrontDoor()
		"giveSolution":
			#QuestLog.finish_a_quest(30)
			gotFakeAnswersFromHolla = true
			control.showInfo("Lösungen für Püfung erhalten")
			get_node("/root/HollaForestScene/ForestLevel/HollaHaus").closeFrontDoor()
			get_node("/root/HollaForestScene/ForestLevel/HollaHaus/HollaDieWaldfee").got_solutions = true
		"leaveHollaLevel":
			print("To Dozent Level...")
			QuestLog.finish_a_quest(10)
			QuestLog.add_quest(60)
			switchToLevel("DozentLevel")

func switchToLevel(levelName):
	control.switchToLevel(levelName)

func start_dialog(dialogManager):
	if dialogActive:
		return
		
	dialogActive = true
	
	if (player and control):
		player.setPause(true)
		control.setDialogManager(dialogManager)
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if dialogManager:
			print(dialogManager)
			dialogManager.start_dialog()
		else:
			print("Error: dialogManager not available")

func stop_dialog():
	dialogActive = false
	
	if (player and control):
		player.setPause(false)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		control.dialog_finished()

func pause_player(pause):
	if player:
		player.setPause(pause)
		if pause:
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func get_controlNode():
	return control


func inspectItem(_item):
	pause_player(true)
	control.get_node("InteractionLabel").visible = false
	player.inspectItem(_item)
	inspecting = true

func stop_inspecting():
	GameController.pause_player(false)
	control.get_node("InteractionLabel").visible = true
	inspecting = false


func openPauseMenue():
	Pause_menue.openPauseMenue()
	pause_player(true)
	pause_menue_open = true

func closePauseMenue():
	Pause_menue.closePauseMenue()
	pause_player(false)
	pause_menue_open = false
