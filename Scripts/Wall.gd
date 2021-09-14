extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Area_body_entered(body):
	if (body.name == "Player"):
		GameController.start_dialog($DialogManager)



func _on_DialogManager_dialog_finished():
	GameController.stop_dialog()


func setColor(color):
	var material = get_surface_material(0)
	material.albedo_color = color
