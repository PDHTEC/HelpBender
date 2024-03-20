class_name MainMenu
extends Node2D

onready var start_button = $start as Button
onready var settings_button = $settings as Button
onready var quit_button = $quit as Button
export var start_level = preload("res://Scenes/Main.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pas

func on_settings_pressed() -> void:
	pass





func _on_start_button_down():
	get_tree().change_scene("res://Scenes/Main.tscn")



func _on_quit_button_down():
	get_tree().quit()
