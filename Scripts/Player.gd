extends KinematicBody

var paused = true

var levelEnded = false

var camera_angle = 0
var mouse_sensitivity = 0.2
var camera_change = Vector2()

var velocity = Vector3()
var direction = Vector3()

# fly variables
const FLY_SPEED = 10
const FLY_ACCEL = 4
var flying = false

# walk variables
var gravity = -9.8 * 3
export var MAX_SPEED = 14
const MAX_RUNNING_SPEED = 20
const ACCEL = 3
const DEACCEL = 8

# jumping
var jump_height = 9
var in_air = 0
var has_contact = false

# slope variables
const MAX_SLOPE_ANGLE = 35

# Called when the node enters the scene tree for the first time.
func _ready():
	GameController.setPlayer(self)
	
	# to let the mouse point raycast ignore the interaction line which is located at the same position
	$Capsule/MousePointCast.add_exception($Head/Camera/InteractionLine)

func _physics_process(delta):
	if paused:
		return
	aim()
	if flying:
		fly(delta)
	else:
		walk(delta)


func _input(event):
	if event is InputEventMouseMotion:
		camera_change = event.relative


func walk(delta):
	# reset direction of the player
	direction = Vector3()
	
	var aim = $Head/Camera.get_global_transform().basis
	
	# check inout and change direction
	if Input.is_action_pressed("move_forward"):
		direction -= aim.z
	if Input.is_action_pressed("move_backward"):
		direction += aim.z
	if Input.is_action_pressed("move_left"):
		direction -= aim.x
	if Input.is_action_pressed("move_right"):
		direction += aim.x
	direction.y = 0
	direction = direction.normalized()
	
	if (is_on_floor()):
		has_contact = true
		var n = $Tail.get_collision_normal()
		var floor_angle = rad2deg(acos(n.dot(Vector3(0,1,0))))
		if floor_angle > MAX_SLOPE_ANGLE:
			velocity.y += gravity * delta
	else:
		if !$Tail.is_colliding():
			has_contact = false
		velocity.y += gravity * delta
	
	if (has_contact and !is_on_floor()):
		move_and_collide(Vector3(0, -1, 0))
	
	var temp_velocity = velocity
	temp_velocity.y = 0
	
	var speed
	if Input.is_action_pressed("move_sprint"):
		speed = MAX_RUNNING_SPEED
	else:
		speed = MAX_SPEED
	
	# where the player would go at max speed
	var target = direction * speed
	
	var acceleration
	if direction.dot(temp_velocity) > 0:
		acceleration = ACCEL
	else:
		acceleration = DEACCEL
	
	# calculate a portion of the distance to go
	temp_velocity = temp_velocity.linear_interpolate(target, acceleration * delta)
	
	velocity.x = temp_velocity.x
	velocity.z = temp_velocity.z
	
	if has_contact and Input.is_action_just_pressed("move_jump"):
		velocity.y = jump_height
		has_contact = false
	
	# move
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
	



func fly(delta):
	# reset direction of the player
	direction = Vector3()
	
	var aim = $Head/Camera.get_global_transform().basis
	
	# check inout and change direction
	if Input.is_action_pressed("move_forward"):
		direction -= aim.z
	if Input.is_action_pressed("move_backward"):
		direction += aim.z
	if Input.is_action_pressed("move_left"):
		direction -= aim.x
	if Input.is_action_pressed("move_right"):
		direction += aim.x
	
	direction = direction.normalized()
	
	# where the player would go at max speed
	var target = direction * FLY_SPEED
	
	# calculate a portion of the distance to go
	velocity = velocity.linear_interpolate(target, FLY_ACCEL * delta)
	
	# move
	move_and_slide(velocity)


func aim():
	$Head.rotate_y(deg2rad(-camera_change.x * mouse_sensitivity))
	
	var change = -camera_change.y * mouse_sensitivity
	if change + camera_angle < 90 and change + camera_angle > -90:
		$Head/Camera.rotate_x(deg2rad(change))
		camera_angle += change
	
	camera_change = Vector2()


func _on_Area_body_entered(body):
	if body.name == "Player":
		flying = true


func _on_Area_body_exited(body):
	if body.name == "Player":
		flying = false

func setPause(pause):
	paused = pause
	
	if levelEnded:
		paused = true


func inspectItem(_item):
	$Head/Camera/ItemInspector.inspectItem(_item)


func get_camera():
	return $Head/Camera

