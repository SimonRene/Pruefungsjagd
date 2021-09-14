extends Button


signal clicked_on_quest(_id)

var quest_id = 0
var quest_title = "Quest Title"
var quest_status = "uncompleted"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_quest_title(_title):
	quest_title = _title
	$HBoxContainer/QuestNameLabel.text = quest_title

func set_quest_id(_id):
	quest_id = _id
	var quest = QuestSystem.get_quest(quest_id)
	set_quest_title(quest.title)

func set_quest_status(_status):
	quest_status = _status
	$HBoxContainer/QuestStatusLabel.text = quest_status


func _on_QuestButton_pressed():
	emit_signal("clicked_on_quest", quest_id)
