extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var start_scale = $"Health bar/Health".scale.x

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/season.text = Global.season
	pass 

func _process(_delta):
	$"Health bar/Health".scale.x= ($"..".health/$"..".max_health)*start_scale
	$"Hunger bar/Hunger".scale.x= ($"..".food/$"..".max_food)*start_scale
	
	pass
