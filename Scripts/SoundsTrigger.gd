extends Spatial


func _ready():
	pass # Replace with function body.


func playWolf():
	$AudioStreamPlayer3DWolf.play()


func _on_AreaWolfTrigger_body_entered(body):
	if body.name == "Player":
		playWolf()
