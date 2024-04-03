extends "res://Scripts/Creature.gd"

export var cowers : bool = true
export var blind : bool = false
export var grounded : bool = false
export var vision_range : float = 20
export var max_spin : float = 5

var y_heading : float

func _ready():
	$VisionArea/CollisionShape.shape.radius = vision_range

func _process(delta):
	if rotation_degrees.y>180:
		rotation_degrees.y -= 360
	elif rotation_degrees.y<-180:
		rotation_degrees.y += 360
	
	if blind:
		$VisionArea.monitoring = false
		$Vision.enabled = false
	else:
		$VisionArea.monitoring = true
		$Vision.enabled = true
	
	movement(delta)

var rotation_acceleration : Vector3
func movement(delta):
	var forwardx = cos(deg2rad(-rotation_degrees.y)-PI/2) * cos(deg2rad(-rotation_degrees.x))
	var forwardz = sin(deg2rad(-rotation_degrees.y)-PI/2) * cos(deg2rad(-rotation_degrees.x))
	if grounded:
		forward = Vector3(forwardx,0,forwardz)
	else:
		var forwardy = sin(deg2rad(y_heading))
		forward = Vector3(forwardx,forwardy,forwardz)
	
	on_ground = $DownRay.is_colliding()
	._update()
	var acceleration : Vector3
	velocity *= 0.97
	acceleration = forward * movement_speed
	acceleration = acceleration.limit_length(movement_speed)
	velocity += acceleration
	velocity = move_and_slide(velocity,-gravity_vector)
	
	random_movement()
	rotation_acceleration = rotation_acceleration.limit_length(max_spin)
	rotation_velocity += rotation_acceleration
	rotation_velocity *= 0.9
	rotation_degrees += rotation_velocity*delta
	
	if animations != null:
		if acceleration.length()>0:
			animations.set_animation("swim")
		else:
			animations.set_animation("idle")

func random_movement():
	rotation_acceleration.y += rand_range(-rotation_speed,rotation_speed)

func move_from(_creature):
	pass
