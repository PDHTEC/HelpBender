extends Control
onready var start_button = $Knapper/resumeButton as Button
onready var settings_button = $Knapper/settingsButton as Button
onready var quit_button = $Knapper/exitButton as Button
onready var settings_menu = $settingsMenu as Control
onready var Knapper = $Knapper as Control
onready var paused = $"." as Control
onready var is_paused = false setget set_is_paused


func _ready():
	handle_connecting_signals()


func _unhandled_input(event):
	if event.is_action_pressed("pause_game"):
		self.is_paused = !is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible =is_paused

func handle_connecting_signals():
	start_button.connect("pressed",self,"_on_start_button_down")
	settings_button.connect("pressed",self,"_on_settings_button_down")
	quit_button.connect("pressed",self,"_on_quit_button_down")
	settings_menu.connect("exit_settings_menu",self,"on_exit_options_menu")

func _on_start_button_down():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	self.is_paused = !is_paused

func _on_settings_button_down():
	Knapper.visible = false
	settings_menu.set_process(true)
	settings_menu.visible = true

func on_exit_options_menu():
	Knapper.visible=true
	settings_menu.visible=false

func _on_quit_button_down():
	get_tree().change_scene("res://Scenes/MenuMain.tscn")
