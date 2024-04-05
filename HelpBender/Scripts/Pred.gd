extends "res://Scripts/Creature.gd"

export var vision_scale : float = 1
export var max_vertical_acc : float = 0.2
export var max_spin : float = 10
var target : Spatial

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement(delta)
	if animations != null:
		pass

func scale_vision(set_scale : float):
	$VisionArea/CollisionShape.scale = Vector3(set_scale,set_scale,set_scale)

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
	velocity *= 0.97
	acceleration = forward * movement_speed
	
	if target!= null && !$VisionArea.get_overlapping_bodies().has(target):
		target = null
		print("Target lost!")
	if target!=null:
		move_to(target.translation)
	else:
		random_movement()
	
	acceleration = acceleration.limit_length(movement_speed)
	velocity += acceleration
	velocity = move_and_slide(velocity,-gravity_vector)
	
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
	$LocalTarget.global_translation = target
	var target_angle_y : float = 0
	var a_squared = Vector2((target-(translation+forward)).x,(target-(translation+forward)).z).length_squared()
	var b_squared = Vector2((target-translation).x,(target-translation).z).length_squared()
	if !is_nan(acos((b_squared+1-a_squared)/(2*sqrt(b_squared)))):
		target_angle_y = rad2deg(acos((b_squared+1-a_squared)/(2*sqrt(b_squared))))
		if $LocalTarget.translation.x>0:
			target_angle_y *= -1
	rotation_acceleration.y = target_angle_y
	acceleration.y += clamp(target.y - translation.y,-max_vertical_acc,max_vertical_acc)

func _on_body_entered_VisionArea(body):
	if body!=self && "creature_level" in body:
		$Vision.cast_to = body.translation-translation
		$Vision.force_raycast_update()
		if $Vision.get_collider() == body && body.creature_level < creature_level:
			if target != null:
				print("new target: "+body.name)
				target = closest_body(target,body)
			else:
				print("target set: "+body.name)
				target = body

func closest_body(body_1, body_2):
	if translation.distance_squared_to(body_1.translation)>translation.distance_squared_to(body_2.translation):
		return body_2

var can_attack : bool = true
var attacking : bool = false
func _on_AttackTimer_timeout():
	if attacking:
		$AttackArea.monitoring = false
		attacking = false
		animations.set_attacking(false)
		$AttackTimer.start(attack_speed)
	else:
		can_attack = true
