extends RigidBody2D

@onready var fire_particles = $FireParticles2D
@onready var point_light = $PointLight2D
@onready var animation_player = $AnimationPlayer

var MAX_SPEED = -1500
var speed = 10
var DIRECTION = Vector2(0.01, -2)
var fuel: float = 20.0
var counter_force:Vector2
var engine_on = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	apply_torque_impulse(1)
	if fuel > 0:
		if linear_velocity.y > MAX_SPEED:
			apply_central_impulse(DIRECTION * speed)
		fuel -= 6 * delta
		print(fuel)
	else:
		if engine_on:
			animation_player.play("engine_off")
			engine_on = false
