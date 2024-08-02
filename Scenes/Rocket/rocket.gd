extends RigidBody2D

@onready var fire_particles = $FireParticles2D
@onready var point_light = $PointLight2D
@onready var animation_player = $AnimationPlayer
@onready var accelaration_timer = $AccelarationTimer
@onready var anti_torque_timer = $AntiTorqueTimer
@onready var smoke_launch_particles = $SmokeLaunchParticles
@onready var smoke_launch_particles_2 = $SmokeLaunchParticles2
@onready var explosion = $Explosion

const MAX_SPEED = -2200
var speed:float = 9.0
const DIRECTION = Vector2(0.05, -2)
var fuel: float = 0.0
var engine_on:bool = false

signal engine_off()

func _ready():
	$SmokeAudio.play()

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
	$SmokeAudio.stop()
	$EngineAudio.play()
	add_constant_torque(50)
	anti_torque_timer.start()
	accelaration_timer.start()
	fire_particles.emitting = true
	point_light.enabled = true
	smoke_launch_particles.emitting = false
	smoke_launch_particles_2.emitting = false
	engine_on = true


func _on_anti_torque_timer_timeout():
	add_constant_torque(-30)


func _on_accelaration_timer_timeout():
	speed += 1


func explode():
	smoke_launch_particles.emitting = false
	smoke_launch_particles_2.emitting = false
	$SmokeAudio.stop()
	$ExplosionAudio.play()
	if engine_on:
		$EngineAudio.stop()
		engine_off.emit()
		engine_on = false
	animation_player.play("explosion")
