extends KinematicBody

export var max_health : float = 20
export var food_value : float = 2
export var movement_speed : float = 2
export var max_speed : float = 20

var food : float
var health : float
var infected : bool

var velocity : Vector3

func change_health(amount):
	set_health(health+amount)

func set_health(amount):
	health = amount
	if health<0:
		health = 0
		die()
	elif health > max_health:
		health = max_health

func die():
	pass
