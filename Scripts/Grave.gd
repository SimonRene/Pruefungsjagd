extends Spatial


func _ready():
	pass # Replace with function body.



func playLightAnim():
	$AnimationPlayer.play("lightAnim")


func stopLightAnim():
	$AnimationPlayer.play("lightNormal")


func _on_Area_body_entered(body):
	if(body.name == "Player"):
		playLightAnim()


func _on_Area_body_exited(body):
	if(body.name == "Player"):
		stopLightAnim()
