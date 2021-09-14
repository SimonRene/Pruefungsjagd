extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var spawns = Array()

var amountSpawned = 1


onready var spawnTimer = Timer.new()

onready var spiderScene = preload("res://RotF/Spider.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(spawnTimer)
	for i in range(22):
		var preset = "Spawn%s"
		var spawnName = preset % str(i+1).pad_zeros(2)
		spawns.append(get_node(spawnName))
	
	spawnTimer.connect("timeout", self, "spawnSpiders")
	spawnTimer.one_shot = true
	spawnTimer.set_wait_time(1)
	spawnTimer.start()




func spawnSpiders():
	
	if (!get_parent().get_node("Fly").alive):
		return
	
	var numberToSpawn = (randi() % 4) + 1
	for i in range(numberToSpawn):
		var index = randi() % 22
		var spider = spiderScene.instance()
		spider.fly = get_parent().get_node("Fly")
		add_child(spider)
		spider.position = spawns[index].position
	
	var nextTime = rand_range(0.5, 2)
	spawnTimer.set_wait_time(nextTime*numberToSpawn)
	spawnTimer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
