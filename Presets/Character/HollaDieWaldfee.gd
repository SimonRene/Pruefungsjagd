extends Node

var got_solutions = false


func _ready():
	pass # Replace with function body.


func talkToHolla():
	if (!got_solutions):
		print("Player talked to Holla die Waldfee")
		get_parent().openFrontDoor()
		GameController.start_dialog($DialogManager)
	else:
		print("Holla has nothing to say.")

func finishedTalkToHolla():
	get_parent().closeFrontDoor()


func _on_Area_body_entered(body):
	if body.name == "Player":
		talkToHolla()
