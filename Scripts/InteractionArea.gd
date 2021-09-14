extends Area


signal player_looking(at)
signal player_looking_stopped()

signal player_interacting()

export var interactionText = "press E to Talk"

var playerLooking = false


func _ready():
	pass # Replace with function body.

func _process(delta):
	if playerLooking:
		if (Input.is_action_just_pressed("interact")):
			print("interacting...")
			emit_signal("player_interacting")


func _on_InteractionArea_area_entered(area):
	if (area.name == "InteractionLine"):
		playerLooking = true
		emit_signal("player_looking", interactionText)


func _on_InteractionArea_area_exited(area):
	if (area.name == "InteractionLine"):
		playerLooking = false
		emit_signal("player_looking_stopped")

