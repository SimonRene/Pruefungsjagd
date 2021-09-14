extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func stopSound():
	$AudioStreamPlayer3D.stop()


func _on_InteractionArea_player_interacting():
	stopSound()
	get_parent().get_node("Smartphone/messageSoundAnimation").play("getMessage")
