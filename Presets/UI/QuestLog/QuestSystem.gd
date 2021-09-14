extends Node


#export (String, FILE, "*.json") var quest_file = null

var quest_data = Dictionary()

var quest_file = "res://Presets/UI/QuestLog/quests.json"


func get_quest(id):
	return quest_data.get(id)


# Called when the node enters the scene tree for the first time.
func _ready():
	if quest_file:
		var file = File.new()
		file.open(quest_file, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		#print("data: ", data)
		
		for quest in data:
			# convert the id provided as float from json int an Integer
			quest.id = int(quest.id)
			quest_data[quest.id] = quest
		
	else:
		print("Error: quests not found")

