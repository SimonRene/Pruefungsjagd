extends Spatial

var current_item

var mouse_start : Vector2 = Vector2(0,0)
var mouse_end : Vector2 = Vector2(0,0)
var dragging = false
var speed = 0.005

onready var cam = get_tree().get_root().get_camera()
onready var x_axis = cam.get_camera_transform().basis[0]
onready var y_axis = cam.get_camera_transform().basis[1]

func _input(e):
	mouse_start = mouse_end
	
	
	#if e is InputEventMouseButton and (e.button_index == BUTTON_RIGHT) and e.is_pressed():
	if e is InputEventMouseButton and e.is_pressed():
		mouse_start = e.position
		dragging = true
		print("Object inspector dragging")
	#if e is InputEventMouseButton and (e.button_index == BUTTON_RIGHT) and not e.is_pressed():
	if e is InputEventMouseButton and not e.is_pressed():
		mouse_start = Vector2(0,0)
		mouse_end = Vector2(0,0)
		dragging = false
	if dragging and e is InputEventMouse:
		mouse_end = e.position


func _process(delta):
	if dragging:
		var mouse_dir = Vector2(mouse_end.x - mouse_start.x, mouse_end.y - mouse_start.y)
		
		#the bigger variable speed is, the faster it'll rotate.
		rotate(y_axis, mouse_dir.x*speed)
		rotate(x_axis, -mouse_dir.y*speed)

func inspectItem(_item):
	add_child(_item.duplicate())
	visible = true
	$StopInspectingButton.visible = true
	current_item = _item

func stopInspecting():
	print("Stop inspecting")
	visible = false
	$StopInspectingButton.visible = false
	GameController.stop_inspecting()
	if(get_child_count() > 1):
		get_child(1).queue_free()
	current_item.get_parent().visible = true
	current_item = null
