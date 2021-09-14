extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var highscore = 42

onready var offMat = preload("res://Models/HollaForest/Arcade/Materials/ArcadeScreenOff.material")
onready var onHerbertMat = preload("res://Models/HollaForest/Arcade/Materials/ArcadeScreenOnHerbert.material")
onready var onHollaMat = preload("res://Models/HollaForest/Arcade/Materials/ArcadeScreenOnHolla.material")

onready var RotF_scene = preload("res://RotF/Scene/RevengeOfTheFly.tscn")
var RotF = null

var hasEnergy = false
var interacted = false

var turnedOn = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func turnOn():
	turnedOn = true
	$AnimationPlayer.stop()
	$Cube2.set_surface_material(1, onHerbertMat)

func setHollaHighcore():
	$Cube2.set_surface_material(1, onHollaMat)


func _on_InteractionArea_player_interacting():
	
	# for testing
	#playArcade()
	#return
	
	
	if (!GameController.talkedToHolla):
		GameController.control.showInfo("funktioniert nicht...")
		return
	
	if (!interacted):
		interacted = true
		GameController.foundArcade = true
		QuestLog.add_quest(40)
	
	if(interacted and GameController.generatorRunning):
		print("Turned on the arcade")
		if !turnedOn:
			turnOn()
		else:
			playArcade()
			
	else:
		GameController.control.showInfo("Die Arcade hat keinen Strom")


func playArcade():
	print("Playing Arcade...")
	
	if (RotF == null):
		GameController.pause_player(true)
		RotF = RotF_scene.instance()
		RotF.highscore = highscore
		add_child(RotF)
		
		
	

func stop_playing():
	if (RotF != null):
		remove_child(RotF)
		RotF.queue_free()
		RotF = null
	
	GameController.pause_player(false)

func got_highscore():
	QuestLog.finish_a_quest(30)
	GameController.control.get_parent().get_node("ForestLevel/HollaHaus/HollaDieWaldfee/hollaConditions").gotHighscore = true
	setHollaHighcore()
