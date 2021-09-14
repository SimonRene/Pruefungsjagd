extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var active_quests = Array()
var completed_quests = Array()
var finished_quests = Array()

var listed_quests = Array()


var log_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	update_quest_list()

func update_quest_list():
	#print(listed_quests)
	#for quest_button in listed_quests:
#		$LogView/ScrollContainer/VBoxContainer.remove_child(quest_button)
	
	var quest_buttons = $LogView/ScrollContainer/VBoxContainer.get_children()
	for i in range(2,quest_buttons.size()):
		quest_buttons[i].queue_free()
	
	#print("Curent Quest:")
	#print("competed: ", completed_quests)
	#print("active: ", active_quests)
	#print("finished: ", finished_quests)
	
	if(completed_quests.size()):
		add_separator("Abzugeben Quests")
	for quest_id in completed_quests:
		add_quest_button(quest_id, "abzugeben")
		
	if(active_quests.size()):
		add_separator("Offene Quests")
	for quest_id in active_quests:
		add_quest_button(quest_id, "ausstehend")
		
	if(finished_quests.size()):
		add_separator("Abgeschlossene Quests")
	for quest_id in finished_quests:
		add_quest_button(quest_id, "abgeschlossen")

func add_quest_button(quest_id, status):
	var quest_button = $LogView/ScrollContainer/VBoxContainer/Button.duplicate()
	quest_button.set_quest_id(quest_id)
	quest_button.get_node("HBoxContainer/QuestStatusLabel").text = status
	# connect the clicked signal of the Quest log button to the method that opens the Quest details
	quest_button.connect("clicked_on_quest", QuestLog, "openQuestDetails")
	
	
	quest_button.visible = true
	$LogView/ScrollContainer/VBoxContainer.add_child(quest_button)

func add_separator(_title):
	var quests_separator = $LogView/ScrollContainer/VBoxContainer/QuestSeparator.duplicate()
	quests_separator.get_node("SeparatorTitle").text = _title
	quests_separator.visible = true
	$LogView/ScrollContainer/VBoxContainer.add_child(quests_separator)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("quest_log")):
		switchQuestLog()

func switchQuestLog():
	log_open = !log_open
	closeQuestDetails()
	$LogView.visible = log_open
	GameController.pause_player(log_open)

func openQuestDetails(_id):
	var quest = QuestSystem.get_quest(_id)
	$QuestDetailBox/VBoxContainer/CenterBox/QuestTitle.text = quest.title
	$QuestDetailBox/VBoxContainer/ScrollContainer/VBoxContainer/PanelContainer/QuestDescription.text = quest.description
	$QuestDetailBox.visible = true

func closeQuestDetails():
	$QuestDetailBox.visible = false




func _on_CloseButton_pressed():
	switchQuestLog()

func add_quest(_id):
	if (!active_quests.has(_id)) and (!completed_quests.has(_id)) and (!finished_quests.has(_id)):
		active_quests.append(_id)
		update_quest_list()
		notify_about_new_quest(_id)


func notify_about_new_quest(_id):
	var quest = QuestSystem.get_quest(_id)
	$NewQuestPanel/QuestTitle.text = quest.title
	$NewQuestPanel/Timer.start()
	$NewQuestPanel.visible = true
	$NewQuestPanel/Timer2.start()


func hide_new_quest_info():
	$NewQuestPanel.visible = false


func play_new_quest_sound():
	$NewQuestPanel/NewQuestAudio.play()



func complete_a_quest(_id):
	if (active_quests.has(_id) and (!completed_quests.has(_id)) and (!finished_quests.has(_id))):
		active_quests.remove(_id)
		completed_quests.append(_id)
		update_quest_list()

func finish_a_quest(_id):
	if ((active_quests.has(_id) or (completed_quests.has(_id))) and (!finished_quests.has(_id))):
		active_quests.erase(_id)
		completed_quests.erase(_id)
		finished_quests.append(_id)
		update_quest_list()
