extends Spatial

export var distance : float = 8
export var max_look : float = 50
export var mouse_sens : float = 0.5

var player
var forward : Vector3

func _ready():
	player = $".."
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$RayCast.cast_to.z = distance

func _process(_delta):
	
	var cam = $Camera
	cam.translation.z = distance
	if $RayCast.is_colliding():
		cam.translation.z = ($RayCast.get_collision_point()-$RayCast.global_translation).length()/1.02
	var forwardx = cos(deg2rad(rotation_degrees.y)-PI/2) * cos(deg2rad(rotation_degrees.x))
	var forwardy = sin(deg2rad(rotation_degrees.x))
	var forwardz = sin(deg2rad(rotation_degrees.y)-PI/2) * cos(deg2rad(rotation_degrees.x))
	forward = Vector3(forwardx,forwardy,forwardz)
	if rotation_degrees.y>180:
		rotation_degrees.y -= 360
	elif rotation_degrees.y<-180:
		rotation_degrees.y += 360

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y += -event.relative.x*mouse_sens
		var changev = -event.relative.y*mouse_sens
		rotation_degrees.x += changev
		if rotation_degrees.x>max_look:
			rotation_degrees.x = max_look
		elif rotation_degrees.x<-max_look:
			rotation_degrees.x = -max_look
