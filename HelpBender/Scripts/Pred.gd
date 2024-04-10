extends "res://Scripts/Creature.gd"

export var vision_scale : float = 1
export var max_vertical_acc : float = 0.2
export var max_spin : float = 10
var target : Spatial
onready var main = get_tree().get_root().get_node("Main")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if main.get_node("Player").translation.distance_squared_to(translation)>main.load_dist:
		return
	movement(delta)
	if attacking:
		for body in $AttackArea.get_overlapping_bodies():
			if body.has_method("attack") && body != self && attacking && body.creature_level<creature_level:
				body.attack(self, attack_power)
				_on_AttackTimer_timeout()

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
		$Vision.force_raycast_update()
		if $Vision.get_collider() != target:
			target = null
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

func move_to(target_pos : Vector3):
	var collision_ahead : bool = $ForwardRay.is_colliding()
	if collision_ahead && !"creature_level" in $ForwardRay.get_collider():
		rotation_acceleration.y += -rotation_speed
		return
	
	$LocalTarget.global_translation = target_pos
	var target_angle_y : float = 0
	var a_squared = Vector2((target_pos-(translation+forward)).x,(target_pos-(translation+forward)).z).length_squared()
	var b_squared = Vector2((target_pos-translation).x,(target_pos-translation).z).length_squared()
	if !is_nan(acos((b_squared+1-a_squared)/(2*sqrt(b_squared)))):
		target_angle_y = rad2deg(acos((b_squared+1-a_squared)/(2*sqrt(b_squared))))
		if $LocalTarget.translation.x>0:
			target_angle_y *= -1
	rotation_acceleration.y = target_angle_y
	acceleration.y += clamp(target_pos.y - translation.y,-max_vertical_acc,max_vertical_acc)

func _on_body_entered_VisionArea(body):
	if body!=self && "creature_level" in body:
		$Vision.rotation.y = -rotation.y
		$Vision.cast_to = body.global_translation-$Vision.global_translation
		$Vision.force_raycast_update()
		#if $Vision.get_collider() != null:
		#	print($Vision.get_collider().name)
		if $Vision.get_collider() == body && body.creature_level < creature_level:
			if target != null:
				target = closest_body(target,body)
			else:
				target = body

func closest_body(body_1, body_2):
	if translation.distance_squared_to(body_1.translation)>translation.distance_squared_to(body_2.translation):
		return body_2

var can_attack : bool = true
var attacking : bool = false
func _on_AttackTimer_timeout():
	if attacking:
		attacking = false
		animations.set_attacking(false)
		$AttackTimer.start(attack_speed)
	else:
		can_attack = true

func _on_AttackArea_body_entered(body):
	if can_attack && body.has_method("attack"):
		$AttackTimer.start(attack_time)
		animations.set_attacking(true)
		can_attack = false
		attacking = true
