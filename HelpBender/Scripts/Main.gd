extends Spatial

export var water_height : float
export var load_dist : float = 100

func _ready():
	load_dist = pow(load_dist,2)
	var creatures = load("res://Scenes/Creature Collections/"+Global.season+".tscn")
	add_child(creatures.instance())
	$Player/Camera.water_visibility(Global.limited_vision)

func _on_Timer_timeout():
	var player = $Player
	Global.score += player.kills*3+player.health*2+player.food
	get_tree().change_scene("res://Scenes/Seasons.tscn")
