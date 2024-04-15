extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$Control/Name.set_max_length(15)
	$Control/Score.text = "score: "+str(Global.score)

func _on_Main_Menu_pressed():
	get_tree().change_scene_to(load("res://Scenes/MenuMain.tscn"))