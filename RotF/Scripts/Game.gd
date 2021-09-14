extends Node


signal score_changed(score)
signal highscore_changed(highscore)

var new_highscore = false

var current_score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("score_changed", current_score)
	emit_signal("highscore_changed", get_parent().highscore)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func score():
	current_score += 1
	emit_signal("score_changed", current_score)
	if(current_score > get_parent().highscore):
		new_highscore = true
		get_parent().set_new_highscore(current_score)
		emit_signal("highscore_changed", get_parent().highscore)
		
		$Fly.play_win()


func game_over():
	get_parent().game_over(new_highscore)
