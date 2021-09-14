extends Control


var input = ""
var unlocked = false
const pin = "2506"

func _ready():
	pass # Replace with function body.


onready var sound1 = preload("res://Sounds/numbers/1.ogg")
onready var sound2 = preload("res://Sounds/numbers/2.ogg")
onready var sound3 = preload("res://Sounds/numbers/3.ogg")
onready var sound4 = preload("res://Sounds/numbers/4.ogg")
onready var sound5 = preload("res://Sounds/numbers/5.ogg")
onready var sound6 = preload("res://Sounds/numbers/6.ogg")
onready var sound7 = preload("res://Sounds/numbers/7.ogg")
onready var sound8 = preload("res://Sounds/numbers/8.ogg")
onready var sound9 = preload("res://Sounds/numbers/9.ogg")

onready var soundWrong = preload("res://Sounds/wrong.ogg")
onready var soundCorrect = preload("res://Sounds/correct.ogg")


func close():
	get_node(".").visible = false
	GameController.pause_player(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if (not unlocked):
		$Device/LockScreen.visible = false
		$Device/NotificationScreen.visible = true
		input = ""
		$Device/LockScreen/PinInputPanel/PinInputLabel.text = input
		

func typeIn(_input):
	if(input.length() < 4):
		input = str(input, _input)
	else:
		print("full")
	
	playSound(str(_input))

func test_pin():
	if (input == pin):
		unlock_device()
	else:
		wrong_pin()
	

func unlock_device():
	print("UNLOCK")
	unlocked = true
	$Device/LockScreen.visible = false
	$Device/HomeScreen.visible = true
	
	playSound("correct")
	get_parent().get_node("Room/Props/Smartphone/MessageLightAnimation").stop()
	get_parent().get_node("Room/Props/Smartphone/messageSoundAnimation").stop()
	QuestLog.finish_a_quest(1)
	QuestLog.add_quest(5)
	GameStatus.phone_unlocked = true

func wrong_pin():
	print("Wrong PIN!!! ", input)
	$Device/LockScreen/wrongPin.visible = true
	
	playSound("wrong")

func _on_CloseButton_pressed():
	close()


func _on_Button_pressed(extra_arg_0):
	$Device/LockScreen/wrongPin.visible = false
	typeIn(extra_arg_0)
	
	$Device/LockScreen/PinInputPanel/PinInputLabel.text = input


func _on_Button_Del_pressed():
	$Device/LockScreen/wrongPin.visible = false
	input = ""
	$Device/LockScreen/PinInputPanel/PinInputLabel.text = input


func _on_Button_Ok_pressed():
	test_pin()


func _on_new_message_pressed():
	$Device/NotificationScreen.visible = false
	$Device/LockScreen.visible = true
	
	QuestLog.add_quest(1)

func playSound(fileName):
	var sfx = null
	match(fileName):
		"1":
			sfx = sound1
		"2":
			sfx = sound2
		"3":
			sfx = sound3
		"4":
			sfx = sound4
		"5":
			sfx = sound5
		"6":
			sfx = sound6
		"7":
			sfx = sound7
		"8":
			sfx = sound8
		"9":
			sfx = sound9
		"correct":
			sfx = soundCorrect
		"wrong":
			sfx = soundWrong
	
	if (sfx != null):
		sfx.set_loop(false)
		$AudioStreamPlayer.stream = sfx
		$AudioStreamPlayer.play()
		
