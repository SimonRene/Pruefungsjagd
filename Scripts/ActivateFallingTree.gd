extends Area

func _ready():
	pass # Replace with function body.


func _on_ActivateFallingTree_body_entered(body):
	
	if (body.name == "Player" and GameController.gotFakeAnswersFromHolla):
		GameController.levelRoot.get_node("ForestLevel").fallingTree()
