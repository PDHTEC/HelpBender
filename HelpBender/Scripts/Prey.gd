extends "res://Scripts/Creature.gd"

export var cowers : bool = true
export var blind : bool = false
export var grounded : bool = false
export var vision_range : float = 20
export var max_spin : float = 5

onready var main := get_tree().get_root().get_node("Main")

var y_heading : float
var rotation_acceleration : Vector3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	$VisionArea/CollisionShape.shape.radius = vision_range
	._ready()

func _process(delta : float):
	if dead:
		queue_free()
	if main.get_node("Player") == null:
		return
	if main.get_node("Player").translation.distance_squared_to(translation)>main.load_dist:
		return
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
	
	if on_ground && grounded && animations != null:
		var ground_normal : Vector3 = $DownRay.get_collision_normal()
		var xform = align_with_y(animations.global_transform, ground_normal)
		animations.global_transform = animations.global_transform.interpolate_with(xform, 0.2)
	
	movement(delta)

func movement(delta : float):
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

func random_movement():
	rotation_acceleration.y += rand_range(-rotation_speed,rotation_speed)

func align_with_y(xform : Transform, new_y : Vector3):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform
