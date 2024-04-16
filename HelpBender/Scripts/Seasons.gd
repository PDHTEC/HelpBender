extends Node2D

onready var season = $Seasons
onready var label = $Label
onready var main_scene = preload("res://Scenes/Main.tscn")

var continue_allowed : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	change_season()
	if Global.year>0:
		rand_effects(1)
		$EndGame.visible = true
	handle_icons()

func _process(_delta : float):
	if continue_allowed:
		$Continue.visible = true
		if Input.is_action_just_pressed("up"):
			get_tree().change_scene_to(main_scene)

func change_season():
	match Global.season:
		"Winter":
			Global.year += 1
			Global.season = "Spring"
			season.region_rect.position.x=0
			label.text = Global.season
			rand_effects(0.05)
		"Spring":
			Global.season = "Summer"
			season.region_rect.position.x=240
			label.text = Global.season
			rand_effects(0.2)
		"Summer":
			Global.season = "Fall"
			season.region_rect.position.x=480
			label.text = Global.season
			rand_effects(0.35)
		"Fall":
			Global.season = "Winter"
			season.region_rect.position.x=720
			label.text = Global.season
			rand_effects(0.6)

func _on_Timer_timeout():
	continue_allowed = true

func rand_effects(chance : float):
	#Global.pollution = false
	#Global.limited_vision = false
	#Global.hungry = false
	#Global.slow = false
	
	if rand_range(0,1)<=chance:
		Global.pollution = true
	if rand_range(0,1)<=chance:
		Global.limited_vision = true
	if rand_range(0,1)<=chance:
		Global.hungry = true
	if rand_range(0,1)<=chance:
		Global.slow = true

func handle_icons():
	var icons = $"Hazard icons"
	if Global.pollution:
		icons.get_node("Pollution").visible = true
	if Global.limited_vision:
		icons.get_node("Visibility").visible = true
	if Global.hungry:
		icons.get_node("Hunger").visible = true
	if Global.slow:
		icons.get_node("Slow").visible = true

func _on_End_Game_pressed():
	get_tree().change_scene("res://Scenes/end game scene.tscn")
