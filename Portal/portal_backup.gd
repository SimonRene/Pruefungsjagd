extends Spatial
class_name Portal2

export(NodePath) var portal_exit_path
export(int) var max_recursion = 1
var portal_exit

var portal_meshes = []

func _ready():
	portal_exit = get_node(portal_exit_path)
	var meshes = $portal_meshes.get_children()
	for i in range(min(max_recursion, meshes.size())):
		portal_meshes.append(meshes[i])
		portal_meshes[i].material_override = portal_meshes[i].material_override.duplicate()
		portal_meshes[i].material_override.set_shader_param("viewport_texture", portal_exit.get_viewport_texture(i))
#		portal_meshes[i].material_override.set_shader_param("recursion_level", i)

func _on_portal_activation_body_entered(body):
	pass
#	body.connect("moved", self, "_on_player_moved")
#	show()

func _on_portal_activation_body_exited(body):
	pass
#	body.disconnect("moved", self, "_on_player_moved")
#	hide()

func _on_player_moved(player):	
	portal_exit.set_camera_position_new(player.camera.global_transform.origin, self, 0, max_recursion)
	portal_exit.set_camera_rotation_new(player.camera.global_transform.basis.orthonormalized().get_euler(),
		global_transform.basis.orthonormalized().get_euler(), 0, max_recursion)
	

func _on_portal_entry_body_entered(body):
	if body is Player && body.get_movement_direction().dot(global_transform.basis.z) < 0: # check if player is moving toward portal
#		var localised_rot = body.global_transform.basis.orthonormalized().get_euler() - global_transform.basis.orthonormalized().get_euler()
#		var target_rot = portal_exit.global_transform.basis.orthonormalized().get_euler() + localised_rot
		var localised_rot = QuatHelpers.localise_rotation(Quat(body.global_transform.basis.orthonormalized()), 
			Quat(global_transform.basis.orthonormalized()))
			
		var target_rot = (Quat(portal_exit.global_transform.basis.orthonormalized()) * localised_rot).normalized()

		body.global_transform.basis = Basis(target_rot)
		var relative_pos = to_local(body.global_transform.origin)
		var new_pos = portal_exit.to_global(relative_pos)
		body.global_transform.origin = new_pos
		
func _on_camera_moved(camera):
	
	if (camera.get_parent().get_parent().name == "Player"):
		var distancePlayerToPortal = (camera.global_transform.origin - self.global_transform.origin).length()
		#print("Distance from cam: ")
		#print(String(distancePlayerToPortal))
		portal_exit.set_cam_distance(max(0.1, distancePlayerToPortal - 1))
	
#	print(camera)
	if camera.global_transform.basis.z.dot(global_transform.basis.z) > 0:
		if camera.recursion_level <= max_recursion:
			portal_exit.update_camera(camera, self)
#		portal_exit.set_camera_position(camera.global_transform.origin, self, camera.recursion_level)
#		portal_exit.set_camera_rotation(camera.global_transform.basis.orthonormalized().get_euler(),
#			global_transform.basis.orthonormalized().get_euler(), camera.recursion_level)
	

func _on_VisibilityNotifier_camera_entered(camera):
#	print("camera")
	if camera is MyCamera:
		camera.connect("camera_moved", self, "_on_camera_moved")

func _on_VisibilityNotifier_camera_exited(camera):
	pass
	if camera is MyCamera:
		camera.disconnect("camera_moved", self, "_on_camera_moved")
