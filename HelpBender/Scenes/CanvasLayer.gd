extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	pause_mode=Node.PAUSE_MODE_PROCESS
	if get_tree().paused:
		visible=true
	else:
		visible=false
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif Input.mouse_mode==Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
