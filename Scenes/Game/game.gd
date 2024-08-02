extends Node2D
@onready var camera = $Rocket/Camera2D
@onready var rocket = $Rocket
@onready var hud = $HUD
@onready var gameover_timer = $GameOverTimer
@onready var alarm_timer = $FiveSecondsTimer/AlarmTimer
@onready var refuel = $HUD/Refuel

var engine_on:bool = false
var is_launched:bool = false
var is_exploded:bool = false
var rocket_velocity = 0
var rocket_hight = 0

func _ready():
	AudioManager.music.stop()
	$WindSFX.play()


func _process(_delta):
	if engine_on: 
		camera.apply_shake()
		
	var time_left = gameover_timer.time_left
	var rocket_fuel = rocket.fuel
	if is_launched and not is_exploded:
		rocket_velocity = round(rocket.linear_velocity.y)
		rocket_hight = round(-rocket.global_position.y)
		
	hud.update_stats(rocket_velocity, time_left, rocket_fuel, rocket_hight)
	
	if Input.is_action_just_pressed("lauch"):
		if not is_launched:
			launch_rocket()


func _physics_process(_delta):
	if is_launched:
		await get_tree().create_timer(1).timeout
		if rocket.get_contact_count() > 0 and not is_exploded:
			is_exploded = true
			explode_rocked(true)


func _on_refuel_refuel(value:int):
	rocket.fuel += value
	rocket.fuel = clamp(rocket.fuel, 0, 100)


func launch_rocket():
	is_launched = true
	engine_on = true
	refuel.hide()
	rocket.start_engine()


func _on_rocket_engine_off():
	engine_on = false


func _on_gameover_timer_timeout():
	refuel.hide()
	alarm_timer.stop()
	explode_rocked(false)


func explode_rocked(grounded:bool):
	is_exploded = true
	gameover_timer.stop()
	$FiveSecondsTimer.stop()
	rocket.explode()
	var tween = create_tween()
	tween.tween_property(camera, "zoom", Vector2(0.3,0.3), 1)
	hud.gameover_menu(rocket_hight, grounded)


func _on_five_seconds_timer_timeout():
	alarm_timer.start()


func _on_alarm_timer_timeout():
	AudioManager.alarm.play()
