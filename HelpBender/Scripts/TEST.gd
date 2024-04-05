extends Spatial

func _process(_delta):
	var ground_normal : Vector3 = $RayCast.get_collision_normal()
	rotation_degrees.x = -rad2deg(Vector3(0,ground_normal.y,ground_normal.z).angle_to(Vector3(0,1,0)))
	rotation_degrees.z = -rad2deg(Vector3(ground_normal.x,ground_normal.y,0).angle_to(Vector3(0,1,0)))
	
