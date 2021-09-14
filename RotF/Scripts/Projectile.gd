extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 444
var dir = Vector2.UP

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(dir * speed * delta)


func _on_Area2D_area_entered(area):
	if area.is_in_group("Spiders"):
		if(area.alive):
			area.hit()
			get_parent().score()


func _on_Area2D_area_exited(area):
	if (area.name == "GameField"):
		queue_free()
