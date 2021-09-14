extends Spatial


var window_open = false


func _ready():
	pass # Replace with function body.


func openWindow():
	if !window_open:
		window_open = true
		$AnimationPlayer.play("OpenWindow")


func _on_InteractionArea_player_interacting():
	print("open rolladen")
	openWindow()
