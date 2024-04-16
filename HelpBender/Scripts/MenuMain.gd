class_name MainMenu
extends Control

onready var start_button = $Knapper/start as Button
onready var settings_button = $Knapper/settings as Button
onready var quit_button = $Knapper/quit as Button
onready var settings_menu = $settingsMenu as Control
onready var refresh_button = $Knapper/refresh as Button
onready var Knapper = $Knapper 
onready var leaderboard = $Leaderboard

export var start_level = preload("res://Scenes/Main.tscn")

func _ready():
	handle_connecting_signals()
	Global.score = 0

func handle_connecting_signals():
	start_button.connect("pressed",self,"_on_start_button_down")
	quit_button.connect("pressed",self,"_on_quit_button_down")
	settings_button.connect("pressed", self, "_on_settings_button_down")
	refresh_button.connect("pressed", self, "_on_refresh_button_down")
	settings_menu.connect("exit_settings_menu",self,"on_exit_options_menu")

func _on_start_button_down():
	Global.year = -1
	Global.score = 0
	Global.season  = "Winter"
	get_tree().change_scene("res://Scenes/Seasons.tscn")

func _on_settings_button_down():
	Knapper.visible = false
	settings_menu.set_process(true)
	leaderboard.visible = false
	settings_menu.visible = true
	print("DOWN")

func _on_quit_button_down():
	get_tree().quit()

func on_exit_options_menu():
	Knapper.visible=true
	settings_menu.visible=false
	leaderboard.visible = true

func _on_refresh_button_down():
	$Leaderboard/NameList.set_text("Loading...")
	$Leaderboard/ScoreList.set_text("")
	$Leaderboard/Control._get_player()
