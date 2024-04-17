extends Node2D

onready var start_scale : float = $"Health bar/Health".scale.x

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/season.text = Global.season

func _process(_delta : float):
	$"Health bar/Health".scale.x= ($"..".health/$"..".max_health)*start_scale
	$"Hunger bar/Hunger".scale.x= ($"..".food/$"..".max_food)*start_scale
	$RichTextLabel.text = "Time left: "+str(int($"../../Timer".time_left))+"s"
