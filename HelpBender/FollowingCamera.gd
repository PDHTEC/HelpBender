extends Spatial

export var distance : float = 5
export var max_look : float = 50
export var mouse_sens : float = 15

var player
var forward : Vector3
var left : Vector3
var up : Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $".."
	$Camera.translation.z = distance
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y += deg2rad(-event.relative.x*mouse_sens)
		var changev = -event.relative.y*mouse_sens
		rotation_degrees.x += deg2rad(changev)
		if rotation_degrees.x>max_look:
			rotation_degrees.x = max_look
		elif rotation_degrees.x<-max_look:
			rotation_degrees.x = -max_look
		var cam = $Camera
		forward = cam.global_translation.direction_to(player.global_translation)
		cam.translation.x += 1
		var tmp = cam.global_translation
		cam.translation.x -= 1
		left = cam.global_translation-tmp
