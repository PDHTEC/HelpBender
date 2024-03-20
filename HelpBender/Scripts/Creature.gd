extends KinematicBody

export var max_health : float = 20
export var max_food : float = 20
export var food_value : float = 2
export var movement_speed : float = 1
export var rotation_speed : float = 0.5
export var attack_speed : float = 2
export var attack_power : float = 5
export var attack_time : float = 1
export var creature_level : int = 1

var food : float
var health : float
var infected : bool
var dead : bool

var velocity : Vector3
var rotation_velocity : Vector3

var gravity_vector : Vector3 = ProjectSettings.get_setting("physics/3d/default_gravity_vector")
var gravity_magnitude : int = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	health = max_health

func attack(attacker, damage):
	change_health(-damage)
	if dead:
		attacker.change_food(food_value)
		queue_free()

func change_food(amount):
	set_food(food+amount)

func set_food(amount):
	food = amount
	if food<0:
		food = 0
		die()
	elif food > max_food:
		food = max_food

func change_health(amount):
	set_health(health+amount)

func set_health(amount):
	health = amount
	if health <= 0:
		health = 0
		die()
	elif health > max_health:
		health = max_health

func die():
	dead = true
