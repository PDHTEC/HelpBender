extends Node2D

onready var season = $Seasons
onready var label = $Label
onready var main_scene = preload("res://Scenes/Main.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	change_season()

func change_season():
	match Global.season:
		"Winter":
			Global.season = "Spring"
			season.region_rect.position.x=0
			label.text = Global.season
		"Spring":
			Global.season = "Summer"
			season.region_rect.position.x=240
			label.text = Global.season
		"Summer":
			Global.year += 1
			Global.season = "Fall"
			season.region_rect.position.x=480
			label.text = Global.season
		"Fall":
			Global.season = "Winter"
			season.region_rect.position.x=720
			label.text = Global.season


func _on_Timer_timeout():
	get_tree().change_scene_to(main_scene)
