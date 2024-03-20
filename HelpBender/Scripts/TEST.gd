extends Spatial

func _process(_delta):
	var ground_normal : Vector3 = $RayCast.get_collision_normal()
	rotation_degrees.x = rad2deg(acos(ground_normal.x))-90
	rotation_degrees.z = rad2deg(asin(ground_normal.z))-90
