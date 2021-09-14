extends Node2D

export var health = 4
var alive = true
 
signal got_hit(new_health)



onready var current_target = self.position


export var speed = 60

var velocity = Vector2.ZERO

var hit_dir = Vector2.ZERO

var current_animation = "Idle"
var min_fly_speed = 40

# the fly can only shoot every ... seconds
var shoot_speed = 0.5
# the cooldown to ensure the last shot was at least "shoot_speed" seconds ago
const Cooldown = preload('res://RotF/Scripts/Cooldown.gd')
var shoot_cooldown


onready var projectile_scene = preload("res://RotF/Projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# instantiate the shooting cooldown
	shoot_cooldown = Cooldown.new(shoot_speed)


func _physics_process(delta):
	
	
	
	# move the fly in the requested direction
	move_fly(delta)
	
	#rotate the fly in the requested direction
	rotate_fly(delta)
	
	# add the time passed to the cooldown
	shoot_cooldown.tick(delta)
	
	# let the correct fly animation play
	update_fly_animation()




# helper functions

func rotate_fly(delta):
	var dir = current_target - self.position
	var target_rotation = dir.normalized().angle()
	
	rotation = (lerp_angle(self.rotation, target_rotation, 0.04)) #+ deg2rad(90)


func lerp_angle(from, to, weight):
	return from + short_angle_dist(from, to) * weight

func short_angle_dist(from, to):
	var max_angle = PI * 2
	var difference = fmod(to - from, max_angle)
	return fmod(2 * difference, max_angle) - difference


func move_fly(delta):
	var dir = current_target - self.position
	
	velocity *= (0.9 * delta)
	
	if (dir.length() > 2):
		velocity += (speed * dir * delta)
	#else:
		#velocity = Vector2.ZERO
	if (hit_dir.length() != 0):
		velocity += hit_dir * delta
		
		hit_dir = hit_dir - (hit_dir * 0.8 * delta)
		if(abs(hit_dir.length()) < 20):
			hit_dir = Vector2.ZERO
	
	translate(velocity * delta)

func update_fly_animation():
	
	# increase the flying animation speed based on the actual velocity
	if (current_animation == "Flying"):
		$AnimationPlayer.playback_speed = max(sqrt(velocity.length()) / 10, 1)
	
	if(abs(velocity.length()) > min_fly_speed) and current_animation != "Flying":
		current_animation = "Flying"
		$AnimationPlayer.play(current_animation)
	if(abs(velocity.length()) <= min_fly_speed) and current_animation == "Flying":
		$AnimationPlayer.playback_speed = 1
		current_animation = "Stopping"
		$AnimationPlayer.play(current_animation)




func _input(event):
	if !alive:
		return
	# Mouse in viewport coordinates
	if event is InputEventMouseMotion:
		current_target = event.position
	elif event is InputEventMouseButton:
		shoot()




func shoot():
	if (shoot_cooldown.is_ready()):
		var projectile = projectile_scene.instance()
		projectile.position = position + $Gun.position.rotated(rotation)
		projectile.rotation = rotation + deg2rad(90)
		projectile.dir = Vector2.UP.rotated(rotation + deg2rad(90))
		get_parent().add_child(projectile)
		
		$ShootSound.play()

func hit(from):
	if(!alive):
		return
	var dir = (position - from).normalized()
	hit_dir += dir * velocity.length() * 100
	health -= 1
	emit_signal("got_hit", health * 25)
	if (health <= 0):
		kill(position)


func kill(from):
	if(alive):
		current_target = position
		#current_animation = "kill"
		#$AnimationPlayer.play(current_animation)
		alive = false
		$Particles2D.restart()
		$Particles2D2.restart()
		$Particles2D3.restart()
		$Particles2D4.restart()
		$Sprite.visible = false
		get_parent().game_over()
		
		$KillSound.play()


func play_idle():
	current_animation = "Idle"
	$AnimationPlayer.play(current_animation)


func play_win():
	$WinSound.play()
