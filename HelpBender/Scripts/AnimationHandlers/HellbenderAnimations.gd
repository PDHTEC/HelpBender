extends Spatial

var animation = "idle"

func set_animation(animation_in : String, speed : float = 1):
	$AnimationTree.set("parameters/movement/conditions/swim",false)
	$AnimationTree.set("parameters/movement/conditions/idle_stand",false)
	$AnimationTree.set("parameters/movement/conditions/walk",false)
	$AnimationTree.set("parameters/movement/conditions/falling",false)
	$AnimationTree.set("parameters/movement/conditions/"+animation_in,true)
	$AnimationTree.set("parameters/animation_speed/scale",speed)
	
	animation = animation_in

func set_attacking(state : bool):
	$AnimationTree.set("parameters/Attack_shot/active",state)
