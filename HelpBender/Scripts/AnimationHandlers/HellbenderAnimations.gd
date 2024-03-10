extends Spatial

var animation = "idle"

func set_animation(animation_in : String):
	$AnimationTree.set("parameters/movement/conditions/swim",false)
	$AnimationTree.set("parameters/movement/conditions/idle_stand",false)
	$AnimationTree.set("parameters/movement/conditions/walk",false)
	$AnimationTree.set("parameters/movement/conditions/falling",false)
	$AnimationTree.set("parameters/movement/conditions/"+animation_in,true)
	animation = animation_in

func set_attacking(state : bool):
	$AnimationTree.set("parameters/Attack_shot/active",state)
