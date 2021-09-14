extends Spatial


func _ready():
	pass 

var treeNotFallen = true

func fallingTree():
	if (treeNotFallen):
		treeNotFallen = false
		$TreesPlaced/animatedFallingTree/AnimationPlayer.play("fallingTree")
