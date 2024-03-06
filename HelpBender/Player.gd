extends "res://Creature.gd"

func attempt_attack():
	var collider = $RayCast.get_collider()
	if collider!=null:
		if collider.has_method("attack"):
			collider.attack(self, attack_power)

func _process(delta):
	movement(delta)
	if Input.is_action_just_pressed("left_click"):
		attempt_attack()

func movement(delta):
	#adds gravity. Uncertain of whether this should be a thing.
	#if !is_on_floor():
	#	velocity += gravity_vector*gravity_magnitude*0.002
	var cam = $Camera
	var forwardx = cos(deg2rad(-rotation_degrees.y)-PI/2) * cos(deg2rad(-rotation_degrees.x))
	var forwardz = sin(deg2rad(-rotation_degrees.y)-PI/2) * cos(deg2rad(-rotation_degrees.x))
	var forward = Vector3(forwardx,cam.forward.y*0.5,forwardz)
	if Input.is_action_pressed("forward"):
		velocity += forward*movement_speed
		rotation_velocity.y += cam.rotation_degrees.y
	if Input.is_action_pressed("back"):
		velocity += forward*-movement_speed*0.25
	if Input.is_action_pressed("left"):
		#velocity += cam.left*movement_speed
		#rotation_velocity.y += 45
		pass
	if Input.is_action_pressed("right"):
		#velocity += cam.left*-movement_speed
		#rotation_velocity.y -= 45
		pass
	velocity *= 0.97
	velocity = velocity.limit_length(max_speed)
	velocity = move_and_slide(velocity,-gravity_vector)
	
	rotation_velocity *= 0.9
	if is_on_floor():
		rotation_velocity*=0.9
	rotation_degrees += rotation_velocity*delta
	cam.rotation_degrees.y -= rotation_velocity.y*delta
	
