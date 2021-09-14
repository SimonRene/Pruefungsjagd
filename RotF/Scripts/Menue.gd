extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func start_game():
	print("Game starting")
	get_parent().get_parent().start_game()

func stop_playing():
	get_parent().get_parent().close_game()

func game_over():
	$VBoxContainer/PanelContainer/Label.text = "Game Over"
	$VBoxContainer/HBoxContainer/Button.text = "Restart"
	visible = true

func new_highscore():
	$VBoxContainer/PanelContainer/Label.text = "New Highscore: " + String(get_parent().get_parent().highscore)
	$VBoxContainer/HBoxContainer/Button.text = "Restart"
	visible = true

func _on_Button_pressed():
	start_game()


func _on_Button_close_pressed():
	stop_playing()
