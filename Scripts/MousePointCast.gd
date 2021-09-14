extends RayCast

var ray_length = 1000
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _input(event):
	if GameController.inspecting:
		if event is InputEventMouse:
			var camera = get_tree().get_root().get_camera()
			var from = camera.project_ray_origin(event.position)
			var to = from + camera.project_ray_normal(event.position) * ray_length
			cast_to = to
			
			if (event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed()):
				if is_colliding():
					print("ray is collinding")
					var obj = get_collider()
					print(obj.get_parent().get_groups())
					print(obj)
					print(obj.get_parent())
					if obj.get_parent().is_in_group("inspect_interactable"):
						obj.get_parent().mouse_clicked()
					else:
						print("raycast collider on flse objets")
