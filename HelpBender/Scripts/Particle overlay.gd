extends Spatial

onready var camera = $"../Player/Camera/Camera"

func _process(delta):
	global_translation = camera.global_translation
