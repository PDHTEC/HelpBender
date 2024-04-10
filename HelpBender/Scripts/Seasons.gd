extends Node2D

onready var season = $Seasons
onready var label = $Label
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	load_season()
	
	pass # Replace with function body.

func load_season():
	match Global.season:
		"Spring":
			season.region.rect.x=0
			label=Global.season
		"Summer":
			season.region.rect.x=240
			label=Global.season
		"Fall":
			season.region.rect.x=480
			label=Global.season
		"Winter":
			season.region.rect.x=720
			label=Global.season
