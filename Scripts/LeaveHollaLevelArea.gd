extends Area


func _ready():
	pass # Replace with function body.


func _on_LeaveLevelArea_body_entered(body):
	if body.name == "Player":
		if GameController.gotFakeAnswersFromHolla:
			print("Leaving Level")
			GameController.start_dialog($DialogManager)
