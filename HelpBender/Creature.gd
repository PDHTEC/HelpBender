extends Spatial

export var max_health : float = 20
export var food_value : float = 2

var food
var health
var infected : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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
