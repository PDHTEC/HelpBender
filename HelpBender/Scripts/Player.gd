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
var on_ground : bool
func movement(delta):
	var cam = $Camera
	var forwardx = cos(deg2rad(-rotation_degrees.y)-PI/2) * cos(deg2rad(-rotation_degrees.x))
	var forwardz = sin(deg2rad(-rotation_degrees.y)-PI/2) * cos(deg2rad(-rotation_degrees.x))
	forward = Vector3(forwardx,0,forwardz)
	#cam.forward.y*0.25
	var real_rot_speed = rotation_speed
	if on_ground:
		real_rot_speed *= 5
	var cam_rotation = cam.rotation_degrees.y
	var acceleration = Vector3.ZERO
	if Input.is_action_pressed("forward"):
		acceleration += forward*movement_speed
		rotation_velocity.y += cam_rotation*real_rot_speed
	if Input.is_action_pressed("back"):
		acceleration += forward*movement_speed
		#acceleration.y -= forward.y*movement_speed*2
		rotation_velocity.y -= cam_rotation*real_rot_speed
	if Input.is_action_pressed("left"):
		acceleration += forward*movement_speed
		#acceleration.y -= forward.y*movement_speed
		var cam_rotation_left = cam_rotation+90
		if cam_rotation_left>180:
			cam_rotation_left -= 360
		elif cam_rotation_left<-180:
			cam_rotation_left += 360
		rotation_velocity.y += (cam_rotation_left)*real_rot_speed
		pass
	if Input.is_action_pressed("right"):
		acceleration += forward*movement_speed
		#acceleration.y -= forward.y*movement_speed
		var cam_rotation_right = cam_rotation-90
		if cam_rotation_right>180:
			cam_rotation_right -= 360
		elif cam_rotation_right<-180:
			cam_rotation_right += 360
		rotation_velocity.y += (cam_rotation_right)*real_rot_speed
	if Input.is_action_pressed("up"):
		acceleration.y += movement_speed*0.5
	if Input.is_action_pressed("down"):
		acceleration.y -= movement_speed*0.5
	
	on_ground = $DownRay.is_colliding()
	var accel_length = acceleration.length()
	
	if on_ground:
		rotation_velocity*=0.6
		velocity *= 0.9
	
	#adds gravity. Uncertain of whether this should be a thing.
	if !on_ground && velocity.length()<=10:
		velocity += gravity_vector*gravity_magnitude*0.01
	
	if on_ground:
		if accel_length>0:
			animations.set_animation("walk",2)
		else:
			animations.set_animation("idle_stand")
	else:
		if accel_length>0:
			animations.set_animation("swim")
		else:
			animations.set_animation("falling")
	
	velocity *= 0.97
	acceleration = acceleration.limit_length(movement_speed)
	velocity += acceleration
	velocity = move_and_slide(velocity,-gravity_vector)
	
	rotation_velocity *= 0.9
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
