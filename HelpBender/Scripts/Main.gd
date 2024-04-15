extends Spatial

export var water_height : float
export var load_dist : float = 100

func _ready():
	load_dist = pow(load_dist,2)
	var creatures = load("res://Scenes/Creature Collections/"+Global.season+".tscn")
	add_child(creatures.instance())
	$Player/Camera.water_visibility(Global.limited_vision)
	$"Player/UI/Hazard icons/cant see icon".visible = Global.limited_vision
	if Global.pollution:
		$Player.const_dmg = 0.1
		$Player/Camera/Camera/WaterPollution.visible = true
		$"Player/UI/Hazard icons/pollution".visible = true
	if Global.hungry:
		$Player.food_drain*=1.5
		$"Player/UI/Hazard icons/hungering icon".visible = true
	if Global.slow:
		$Player.movement_speed*=0.75
		$"Player/UI/Hazard icons/slow icon".visible = true
	

func _on_Timer_timeout():
	var player = $Player
	Global.score += player.kills*3+player.health*2+player.food
	get_tree().change_scene("res://Scenes/Seasons.tscn")
