extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var scoreLabel = $HContainer/HBoxContainer2/ScorePanel/Score
onready var highscoreLabel = $HContainer/HBoxContainer/HighscorePanel/Highscore
onready var healthLabel = $HContainer/HBoxContainer3/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_score(score):
	scoreLabel.text = String(score)

func update_highscore(highscore):
	highscoreLabel.text = String(highscore)

func update_health(health):
	healthLabel.text = String(health)


func _on_Fly_got_hit(new_health):
	update_health(new_health)


func _on_Game_score_changed(score):
	update_score(score)


func _on_Game_highscore_changed(highscore):
	update_highscore(highscore)
