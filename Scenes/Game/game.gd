extends Node2D
@onready var camera = $Rocket/Camera2D
@onready var rocket = $Rocket
@onready var hud = $HUD
@onready var gameover_timer = $GameOverTimer
@onready var refuel = $HUD/Refuel

var engine_on:bool = false
var launched:bool = false
var rocket_hight = 0
func _ready():
	gameover_timer.start()

func _process(_delta):
	var rocket_velocity = round(rocket.linear_velocity.y)
	var time_left = gameover_timer.time_left
	var rocket_fuel = rocket.fuel
	
	if engine_on:
		camera.apply_shake()
		rocket_hight = -round(rocket.global_position.y)
		
	hud.update_stats(rocket_velocity, time_left, rocket_fuel, rocket_hight)
	
	if Input.is_action_just_pressed("lauch"):
		if not launched:
			launch_rocket()


func _on_refuel_refuel(value:int):
	rocket.fuel += value
	rocket.fuel = clamp(rocket.fuel, 0, 100)

func launch_rocket():
	launched = true
	engine_on = true
	refuel.hide()
	rocket.start_engine()


func _on_rocket_engine_off():
	engine_on = false


func _on_timer_timeout():
	rocket.explode()
	var tween = create_tween()
	tween.tween_property(camera, "zoom", Vector2(0.3,0.3), 1)
	print('rocket_hight ', rocket_hight)
	hud.gameover_menu(rocket_hight, false)
