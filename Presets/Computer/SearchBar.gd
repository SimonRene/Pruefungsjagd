extends LineEdit


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var typed = false


func runTypeAnimation():
	if GameStatus.phone_unlocked and !typed:
		typed = true
		print("typing...")
		$Label/AnimationPlayer.play("TypeInSearchBar")


func _on_SearchBar_focus_entered():
	runTypeAnimation()
