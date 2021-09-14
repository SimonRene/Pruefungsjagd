extends Spatial


var backdoorOpened = false
var backDoorLocked = false

var door_A_opened = false
var door_B_opened = false

var doorUpstairsOpened = false
var doorUpstairsLocked = true

signal needKeyCard
signal needKey

func _ready():
	pass # Replace with function body.


func openBackDoor():
	if !backdoorOpened:
		$DoorBackside/AnimationPlayer.play("OpenBackDoor")
		backdoorOpened = true
	else:
		$DoorBackside/AnimationPlayer.play("LockedDoorSound")

func closeBackDoor():
	if backdoorOpened and !backDoorLocked:
		$DoorBackside/AnimationPlayer.play("CloseBackDoor")
		backDoorLocked = true


func _on_CloseDoorArea_body_entered(body):
	print("Entered")
	print(body.name)
	if body.name == "Player":
		closeBackDoor()


func openDoorUpstairs():
	if doorUpstairsOpened:
		return
	
	if doorUpstairsLocked:
		if GameController.haveKeyForDoorUpstairs:
			$Door_to_unlock/AnimationPlayer.play("OpenDoorUpstairs")
		else:
			$Door_to_unlock/AnimationPlayer.play("DoorUpstairsLocked")
			emit_signal("needKey")
		return
	
	$Door_to_unlock/AnimationPlayer.play("OpenDoorUpstairs")
	doorUpstairsOpened = true



func _on_InteractionArea2_player_interacting():
	openDoorUpstairs()




func openDoorA():
	if GameController.haveKeycardDoorA and !door_A_opened:
		$Door_A_left/AnimationPlayer.play("open_Door_A")
		door_A_opened = true
		GameController.control.showInfo("mit Schlüsselkarte geöffnet")
	elif !door_A_opened:
		emit_signal("needKeyCard")

func openDoorB():
	if GameController.haveKeycardDoorB and !door_B_opened:
		$Door_B_left/AnimationPlayer.play("open_Door_B")
		door_B_opened = true
		GameController.control.showInfo("mit Schlüsselkarte geöffnet")
	elif !door_B_opened:
		emit_signal("needKeyCard")


func _on_Open_Door_A_Area_body_entered(body):
	if body.name == "Player":
		openDoorA()


func _on_Open_Door_B_Area_body_entered(body):
	if body.name == "Player":
		openDoorB()
