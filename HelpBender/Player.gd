extends "res://Creature.gd"

func _process(delta):
	if rotation_degrees.y>180:
		rotation_degrees.y -= 360
	elif rotation_degrees.y<-180:
		rotation_degrees.y += 360
	movement(delta)
	if Input.is_action_just_pressed("left_click") && can_attack:
		attempt_attack()

func attempt_attack():
	$AttackTimer.start(attack_speed)
	velocity += forward*10
	can_attack = false
	var collider = $RayCast.get_collider()
	if collider!=null:
		if collider.has_method("attack"):
			collider.attack(self, attack_power)

var forward : Vector3
var left : Vector3
func movement(delta):
	#adds gravity. Uncertain of whether this should be a thing.
	#if !is_on_floor():
	#	velocity += gravity_vector*gravity_magnitude*0.002
	var cam = $Camera
	var forwardx = cos(deg2rad(-rotation_degrees.y)-PI/2) * cos(deg2rad(-rotation_degrees.x))
	var forwardz = sin(deg2rad(-rotation_degrees.y)-PI/2) * cos(deg2rad(-rotation_degrees.x))
	forward = Vector3(forwardx,cam.forward.y*0.25,forwardz)
	var leftx = cos(deg2rad(-rotation_degrees.y)) * cos(deg2rad(-rotation_degrees.x))
	var leftz = sin(deg2rad(-rotation_degrees.y)) * cos(deg2rad(-rotation_degrees.x))
	left = Vector3(leftx,0,leftz)
	
	var cam_rotation = cam.rotation_degrees.y
	#if abs(cam_rotation-rotation_degrees.y)>180:
	#	if abs(cam_rotation-(rotation_degrees.y-360))<180:
	#		rotation_degrees.y -= 360
	#	else:
	#		rotation_degrees.y += 360
	#print(rotation_degrees,cam_rotation)
	var acceleration = Vector3.ZERO
	if Input.is_action_pressed("forward"):
		acceleration += forward*movement_speed
		rotation_velocity.y += cam_rotation
	if Input.is_action_pressed("back"):
		acceleration += forward*movement_speed
		acceleration.y -= forward.y*movement_speed*2
		rotation_velocity.y -= cam_rotation
	if Input.is_action_pressed("left"):
		#velocity += cam.left*movement_speed
		#rotation_velocity.y += 45
		pass
	if Input.is_action_pressed("right"):
		#velocity += cam.left*-movement_speed
		#rotation_velocity.y -= 45
		pass
	velocity *= 0.97
	acceleration = acceleration.limit_length(movement_speed)
	velocity += acceleration
	velocity = move_and_slide(velocity,-gravity_vector)
	
	rotation_velocity *= 0.9
	if is_on_floor():
		rotation_velocity*=0.9
	rotation_degrees += rotation_velocity*delta
	cam.rotation_degrees.y -= rotation_velocity.y*delta

var can_attack : bool = true
func _on_AttackTimer_timeout():
	can_attack = true
