extends Node2D

export var movement : Vector2 = Vector2(50,50)
export var movement_variation : float = 50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Water.texture_offset.x += movement.x*delta+rand_range(-movement_variation,movement_variation)*delta
	$Water.texture_offset.y += movement.y*delta+rand_range(-movement_variation,movement_variation)*delta
