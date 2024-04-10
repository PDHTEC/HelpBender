extends Node2D

onready var season = $Seasons
onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	change_season()

func change_season():
	match Global.season:
		"Winter":
			Global.season = "Spring"
			season.region_rect.x=0
			label=Global.season
		"Spring":
			Global.season = "Summer"
			season.region_rect.x=240
			label=Global.season
		"Summer":
			Global.year += 1
			Global.season = "Fall"
			season.region_rect.x=480
			label=Global.season
		"Fall":
			Global.season = "Winter"
			season.region_rect.x=720
			label=Global.season
