extends Spatial

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Water Ambient SFX".play()



func _process(_delta : float):
	if $"..".acceleration.length()>0:
		if$"Movment SFX".playing==false:
			$"Movment SFX".play()
	else:
		$"Movment SFX".stop()
