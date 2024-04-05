extends KinematicBody

export var max_health := 20.0
export var max_food := 20.0
export var food_value := 2.0
export var movement_speed := 1.0
export var rotation_speed := 0.5
export var attack_speed := 2.0
export var attack_power := 5.0
export var attack_time := 1.0
export var creature_level := 1
export var animations_path : NodePath

var animations : Spatial
var food : float
var health : float
var infected : bool
var dead : bool
var forward : Vector3
var on_ground : bool

var velocity : Vector3
var rotation_velocity : Vector3

var gravity_vector : Vector3 = ProjectSettings.get_setting("physics/3d/default_gravity_vector")
var gravity_magnitude : int = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	health = max_health
	if str(animations_path).length()>0:
		animations = get_node(animations_path)

func _update():
	#Gravity
	#if velocity.length()<=10:
	#	velocity += gravity_vector*gravity_magnitude*0.01
	velocity += gravity_vector*gravity_magnitude*0.01

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
