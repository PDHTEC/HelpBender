extends "res://Creature.gd"

func attempt_attack():
	var collider = $RayCast.get_collider()
	if collider!=null:
		if collider.has_method("attack"):
			collider.attack(self, attack_power)

func _process(delta):
	movement()
	if Input.is_action_just_pressed("ui_accept"):
		attempt_attack()

func movement():
	#adds gravity. Uncertain of whether this should be a thing.
	#if !is_on_floor():
	#	velocity += gravity_vector*gravity_magnitude*0.002
	
	if Input.is_action_pressed("forward"):
		velocity += $Camera.forward*movement_speed
	if Input.is_action_pressed("back"):
		velocity += $Camera.forward*-movement_speed
	if Input.is_action_pressed("left"):
		velocity += $Camera.left*movement_speed
	if Input.is_action_pressed("right"):
		velocity += $Camera.left*-movement_speed
	velocity *= 0.9
	velocity = velocity.limit_length(max_speed)
	velocity = move_and_slide(velocity,-gravity_vector)
