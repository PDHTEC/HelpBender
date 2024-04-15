extends Node2D

onready var control = $Control
func _ready():
	control._get_player()

