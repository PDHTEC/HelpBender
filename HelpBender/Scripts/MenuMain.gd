class_name MainMenu
extends Control

onready var start_button = $Knapper/start as Button
onready var settings_button = $Knapper/settings as Button
onready var quit_button = $Knapper/quit as Button
onready var settings_menu = $settingsMenu as Control
onready var Knapper = $Knapper 

export var start_level = preload("res://Scenes/Main.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	handle_connecting_signals()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pas



func handle_connecting_signals():
	start_button.connect("pressed",self,"_on_start_button_down")
	settings_button.connect("pressed",self,"_on_settings_button_down")
	quit_button.connect("pressed",self,"_on_quit_button_down")
	settings_menu.connect("exit_settings_menu",self,"on_exit_options_menu")
	
	pass
	

func _on_start_button_down():
	get_tree().change_scene("res://Scenes/Main.tscn")

func _on_settings_button_down():
	Knapper.visible = false
	settings_menu.set_process(true)
	settings_menu.visible = true


func _on_quit_button_down():
	get_tree().quit()

func on_exit_options_menu():
	Knapper.visible=true
	settings_menu.visible=false
