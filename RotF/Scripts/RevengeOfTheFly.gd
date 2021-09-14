extends Node

signal holla_highscore

var Holla_has_highscore = false
var highscore = 3

onready var game_scene = preload("res://RotF/Scene/Game.tscn")

var game = null

func _ready():
	connect("holla_highscore", get_parent(), "got_highscore")
	pass


func _process(delta):
	if Input.is_action_just_pressed("restartLevel"):
		get_tree().reload_current_scene()


func start_game():
	
	$CenterContainer/Menue.visible = false
	
	if (game != null):
		game.queue_free()
		remove_child(game)
	
	game = game_scene.instance()
	
	add_child(game)


func close_game():
	get_parent().stop_playing()


func game_over(new_highscore):
	if(new_highscore):
		$CenterContainer/Menue.new_highscore()
	else:
		$CenterContainer/Menue.game_over()


func set_new_highscore(_highscore):
	highscore = _highscore
	
	if (!Holla_has_highscore):
		Holla_has_highscore = true
		emit_signal("holla_highscore")
