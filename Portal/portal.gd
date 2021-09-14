extends Spatial
class_name Portal

# The Portal functionality is from https://github.com/DeleteSystem32/godot-portal-example
# I modified it to macht the requirements and to get a better performance (which is still bad)

export(NodePath) var portal_exit_path
export(int) var max_recursion = 1
var portal_exit

export(bool) var update_cam_near = false

var is_active = true

var rot_diff_entry_to_exit = 0.0

export(float) var cam_distance = 1.0

var portal_meshes = []

func _ready():
	portal_exit = get_node(portal_exit_path)
	
	var portal_rot = rad2deg(self.rotation.y)
	var exit_rot = rad2deg(portal_exit.rotation.y)
	
	if (portal_rot < 0):
		portal_rot = 360 + portal_rot
	
	if (exit_rot < 0):
		exit_rot = 360 + exit_rot
	
	rot_diff_entry_to_exit = deg2rad(exit_rot - portal_rot)
	
	var meshes = $portal_meshes.get_children()
	for i in range(min(max_recursion, meshes.size())):
		portal_meshes.append(meshes[i])
		portal_meshes[i].material_override = portal_meshes[i].material_override.duplicate()
		portal_meshes[i].material_override.set_shader_param("viewport_texture", portal_exit.get_viewport_texture(i))

func _on_portal_activation_body_entered(body):
	pass

func _on_portal_activation_body_exited(body):
	pass

func _on_player_moved(player):
	if (!visible):
		return
	portal_exit.set_camera_position_new(player.camera.global_transform.origin, self, 0, max_recursion)
	portal_exit.set_camera_rotation_new(player.camera.global_transform.basis.orthonormalized().get_euler(),
		global_transform.basis.orthonormalized().get_euler(), 0, max_recursion)


func _on_portal_entry_body_entered(body):
	if (!is_active):
		return
	if body is Player && body.get_movement_direction().dot(global_transform.basis.z) < 0: # check if player is moving toward portal
		var localised_rot = QuatHelpers.localise_rotation(Quat(body.global_transform.basis.orthonormalized()), 
			Quat(global_transform.basis.orthonormalized()))
			
		var target_rot = (Quat(portal_exit.global_transform.basis.orthonormalized()) * localised_rot).normalized()
		
		body.rotateVelocity(rot_diff_entry_to_exit)
		
		body.global_transform.basis = Basis(target_rot)
		var relative_pos = to_local(body.global_transform.origin)
		var new_pos = portal_exit.to_global(relative_pos)
		body.global_transform.origin = new_pos
		
func _on_camera_moved(camera):
	if (!is_active):
		return
		
	if (camera.get_parent().get_parent().name == "Player"):
		if(update_cam_near):
			var distancePlayerToPortal = (camera.global_transform.origin - self.global_transform.origin).length()

			var cam_near_value = 0.05

			if (distancePlayerToPortal > cam_distance):
				cam_near_value = distancePlayerToPortal - cam_distance

			portal_exit.set_cam_distance(cam_near_value)
		
		
		
		if camera.global_transform.basis.z.dot(global_transform.basis.z) > 0:
			if camera.recursion_level <= max_recursion:
				portal_exit.update_camera(camera, self)


func _on_VisibilityNotifier_camera_entered(camera):
	if !is_active:
		return
	
	if camera is MyCamera and camera == GameController.player.get_camera():
		camera.connect("camera_moved", self, "_on_camera_moved")

func _on_VisibilityNotifier_camera_exited(camera):
	if !is_active:
		return

	if camera is MyCamera and camera == GameController.player.get_camera():
		camera.disconnect("camera_moved", self, "_on_camera_moved")


func disable_portal():
	is_active = false
	portal_exit.disable_portal_exit()
	
	hide()
	get_parent().hide()
	
	print("Disablening portal")

func enable_portal():
	is_active = true
	portal_exit.enable_portal_exit()
	
	show()
	get_parent().show()
	
	print("Enableing portal")


func _on_VisibilityNotifier_screen_entered():
	if !is_active:
		return
	
	GameController.player.get_camera().connect("camera_moved", self, "_on_camera_moved")


func _on_VisibilityNotifier_screen_exited():
	if !is_active:
		return
	
	GameController.player.get_camera().disconnect("camera_moved", self, "_on_camera_moved")
