extends RigidBody2D

@onready var fire_particles = $FireParticles2D
@onready var point_light = $PointLight2D
@onready var animation_player = $AnimationPlayer
@onready var accelaration_timer = $AccelarationTimer
@onready var anti_torque_timer = $AntiTorqueTimer

const MAX_SPEED = -2200
var speed:float = 9.0
const DIRECTION = Vector2(0.05, -2)
var fuel: float = 0.0
var counter_force:Vector2
var engine_on:bool = false

signal engine_off()

func _physics_process(delta):
	if engine_on:
		if fuel > 0:
			if linear_velocity.y > MAX_SPEED:
				apply_central_impulse(DIRECTION * speed)
			fuel -= 7 * delta
		else:
			if engine_on:
				engine_off.emit()
				animation_player.play("engine_off")
				engine_on = false


func start_engine():
	add_constant_torque(50)
	anti_torque_timer.start()
	accelaration_timer.start()
	fire_particles.emitting = true
	point_light.enabled = true
	engine_on = true


func _on_anti_torque_timer_timeout():
	add_constant_torque(-30)


func _on_accelaration_timer_timeout():
	speed += 1
