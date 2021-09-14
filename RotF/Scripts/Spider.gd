extends Area2D

export var speed = 50


onready var timer = Timer.new()

var alive = true

var fly = null

var nextSound = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#fly = get_node("/root/RevengeOfTheFly/Game/Fly")
	print(fly)
	
	nextSound = randi() % 3
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	move(delta)


func move(delta):
	if !alive:
		return
		
	if fly == null:
		return
	
	if(!fly.alive):
		rotate(deg2rad(90) * delta)
		return
	

	var target = fly.position
	
	var path = target - position
	
	var dir = path.normalized()
	
	translate(dir * speed * delta)
	
	look_at(fly.position)


func hit():
	if !alive:
		return
	alive = false
	$Sprite.visible = false
	
	timer.connect("timeout", self, "deleteSpider")
	timer.set_wait_time(2)
	add_child(timer)
	timer.one_shot = true
	timer.start()
	
	$Sprite.visible = false
	
	$Particles2D.restart()
	$Particles2D2.restart()
	$Particles2D3.restart()
	
	play_splatter_sound()
	

func play_splatter_sound():
	
	var ran = (randi() % 2)
	
	nextSound += (ran + 1)
	
	var soundName = "KillSound" + String(nextSound % 3)
	
	get_node(soundName).play()


func deleteSpider():
	queue_free()
	


func _on_Spider_area_entered(area):
	
	if area.name == "Fly" and alive:
		play_splatter_sound()
		area.hit(position)


func _on_DeadlyCenter_area_entered(area):
	if area.name == "Fly" and alive:
		area.kill(position)
