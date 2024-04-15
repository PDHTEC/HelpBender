extends Spatial

export var water_height : float
export var load_dist : float = 100

func _ready():
	load_dist = pow(load_dist,2)

func _on_Timer_timeout():
	var player = $Player
	Global.score += player.health+player.food
	get_tree().change_scene("res://Scenes/Seasons.tscn")
