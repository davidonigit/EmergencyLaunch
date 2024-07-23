extends Camera2D

@export var random_strenght: float = 3.0
@export var shake_fade: float = 1.0

var rng = RandomNumberGenerator.new()

var shake_strenght: float = 0.0
var is_shaking:bool = false

func apply_shake():
	shake_strenght = random_strenght
	is_shaking = true


func _process(delta):
	if shake_strenght > 0:
		shake_strenght = lerpf(shake_strenght,0,shake_fade*delta)
		
		offset = random_offset()
		
func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strenght,shake_strenght),rng.randf_range(-shake_strenght,shake_strenght))
