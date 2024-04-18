class_name settingsMenu extends Control

onready var exit_button = $exitButton

signal exit_settings_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	exit_button.connect("pressed",self,"_on_exit_button_button_down")
	set_process(false)

func _on_exit_button_button_down():
	emit_signal("exit_settings_menu")
	set_process(false)

