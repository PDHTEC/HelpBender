extends "res://Scripts/Creature.gd"

var animations
func _ready():
	animations = $Hellbender

func _process(delta):
	if rotation_degrees.y>180:
		rotation_degrees.y -= 360
	elif rotation_degrees.y<-180:
		rotation_degrees.y += 360
	
	movement(delta)
	
	if Input.is_action_just_pressed("left_click") && can_attack:
		attempt_attack()
	if attacking:
		var collider = $FrontRay.get_collider()
		if collider!=null:
			if collider.has_method("attack"):
				collider.attack(self, attack_power)
			_on_AttackTimer_timeout()

func attempt_attack():
	$AttackTimer.start(attack_time)
	animations.set_attacking(true)
	velocity += forward*10
	can_attack = false
	attacking = true

var forward : Vector3
var left : Vector3
var on_ground : bool
func movement(delta):
	#adds gravity. Uncertain of whether this should be a thing.
	#if on_ground:
	#	velocity += gravity_vector*gravity_magnitude*0.005
	var cam = $Camera
	var forwardx = cos(deg2rad(-rotation_degrees.y)-PI/2) * cos(deg2rad(-rotation_degrees.x))
	var forwardz = sin(deg2rad(-rotation_degrees.y)-PI/2) * cos(deg2rad(-rotation_degrees.x))
	forward = Vector3(forwardx,cam.forward.y*0.25,forwardz)
	var leftx = cos(deg2rad(-rotation_degrees.y)) * cos(deg2rad(-rotation_degrees.x))
	var leftz = sin(deg2rad(-rotation_degrees.y)) * cos(deg2rad(-rotation_degrees.x))
	left = Vector3(leftx,0,leftz)
	
	var cam_rotation = cam.rotation_degrees.y
	var acceleration = Vector3.ZERO
	if Input.is_action_pressed("forward"):
		acceleration += forward*movement_speed
		rotation_velocity.y += cam_rotation
	if Input.is_action_pressed("back"):
		acceleration += forward*movement_speed
		acceleration.y -= forward.y*movement_speed*2
		rotation_velocity.y -= cam_rotation
	if Input.is_action_pressed("left"):
		#acceleration += forward*movement_speed
		#acceleration.y -= forward.y*movement_speed*2
		#rotation_velocity.y -= cam_rotation
		pass
	if Input.is_action_pressed("right"):
		#velocity += cam.left*-movement_speed
		#rotation_velocity.y -= 45
		pass
	
	on_ground = $DownRay.is_colliding()
	
	if on_ground:
		rotation_velocity*=0.6
		velocity *= 0.97
	
	if on_ground:
		if acceleration.length()>0:
			animations.set_animation("walk")
		else:
			animations.set_animation("idle_stand")
	else:
		if acceleration.length()>0:
			animations.set_animation("swim")
	
	velocity *= 0.97
	acceleration = acceleration.limit_length(movement_speed)
	velocity += acceleration
	velocity = move_and_slide(velocity,-gravity_vector)
	
	rotation_velocity *= 0.9
	rotation_velocity = rotation_velocity.limit_length(rotation_speed)
	rotation_degrees += rotation_velocity*delta
	cam.rotation_degrees.y -= rotation_velocity.y*delta

var can_attack : bool = true
var attacking : bool = false
func _on_AttackTimer_timeout():
	if attacking:
		attacking = false
		animations.set_attacking(false)
		$AttackTimer.start(attack_speed)
	else:
		can_attack = true
