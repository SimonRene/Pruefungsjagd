extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func hideHollaAtDoor():
	$Holla_Animated_10.visible = false

func showHollaAtDoor():
	$Holla_Animated_10.visible = true

func openDoor():
	$AnimationTree["parameters/conditions/openDoor"] = true
	$AnimationTree["parameters/conditions/closeDoor"] = false

func closeDoor():
	$AnimationTree["parameters/conditions/closeDoor"] = true
	$AnimationTree["parameters/conditions/openDoor"] = false
