extends "res://Scripts/Creature.gd"

export var vision_range : float = 20
export var max_spin : float = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	$VisionArea/CollisionShape.shape.radius = vision_range

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement(delta)
	if animations != null:
		pass

var x_heading : float
var acceleration : Vector3
var rotation_acceleration : Vector3
func movement(delta):
	var forwardx = cos(deg2rad(-rotation_degrees.y)-PI/2) * cos(deg2rad(-rotation_degrees.x))
	var forwardz = sin(deg2rad(-rotation_degrees.y)-PI/2) * cos(deg2rad(-rotation_degrees.x))
	var forwardy = sin(deg2rad(x_heading))
	forward = Vector3(forwardx,forwardy,forwardz)
	
	on_ground = $DownRay.is_colliding()
	._update()
	var acceleration : Vector3
	velocity *= 0.97
	acceleration = forward * movement_speed
	acceleration = acceleration.limit_length(movement_speed)
	velocity += acceleration
	velocity = move_and_slide(velocity,-gravity_vector)
	move_to($"../Player".translation)
	#random_movement()
	rotation_acceleration = rotation_acceleration.limit_length(max_spin)
	rotation_velocity += rotation_acceleration
	rotation_velocity *= 0.9
	rotation_degrees.y += rotation_velocity.y*delta
	
	if animations != null:
		if acceleration.length()>0:
			animations.set_animation("swim")
		else:
			animations.set_animation("idle")

func random_movement():
	var collision_ahead : bool = $ForwardRay.is_colliding()
	if !collision_ahead:
		rotation_acceleration.y += rand_range(-rotation_speed,rotation_speed)
		x_heading += rand_range(-rotation_speed,rotation_speed)*0.1
	else:
		rotation_acceleration.y += -rotation_speed

func move_to(target : Vector3):
	var targeting_angle := Vector2.ZERO
	var b_squared = Vector2(target.x,target.z).length_squared()
	var a_squared = Vector2(-target.x,1-target.z).length_squared()
	targeting_angle.x = acos((b_squared+1-a_squared)/(2*sqrt(a_squared)))
