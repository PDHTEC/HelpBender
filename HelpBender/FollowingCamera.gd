extends Spatial

export var distance : float = 8
export var max_look : float = 50
export var mouse_sens : float = 0.5

var player
var forward : Vector3
var left : Vector3
var up : Vector3

func _ready():
	player = $".."
	$Camera.translation.z = distance
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var cam = $Camera
	#forward = cam.global_translation.direction_to(player.global_translation)
	cam.translation.x += 0.01
	var tmp = cam.global_translation
	cam.translation.x -= 0.01
	left = (cam.global_translation-tmp).normalized()

func _process(delta):
	var forwardx = cos(deg2rad(rotation_degrees.y)-PI/2) * cos(deg2rad(rotation_degrees.x))
	var forwardy = sin(deg2rad(rotation_degrees.x))
	var forwardz = sin(deg2rad(rotation_degrees.y)-PI/2) * cos(deg2rad(rotation_degrees.x))
	forward = Vector3(forwardx,forwardy,forwardz)

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y += -event.relative.x*mouse_sens
		var changev = -event.relative.y*mouse_sens
		rotation_degrees.x += changev
		if rotation_degrees.x>max_look:
			rotation_degrees.x = max_look
		elif rotation_degrees.x<-max_look:
			rotation_degrees.x = -max_look
