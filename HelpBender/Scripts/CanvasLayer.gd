extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	visible = false

func _process(_delta):
	pause_mode=Node.PAUSE_MODE_PROCESS
	if get_tree().paused:
		visible=true
	else:
		visible=false
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
