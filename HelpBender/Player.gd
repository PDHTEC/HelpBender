extends "res://Creature.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	movement()

func movement():
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
	velocity = move_and_slide(velocity,Vector3.ZERO)
