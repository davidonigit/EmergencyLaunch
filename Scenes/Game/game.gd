extends Node2D
@onready var camera = $Rocket/Camera2D
@onready var rocket = $Rocket
@onready var hud = $HUD
@onready var timer = $Timer


func _ready():
	timer.start()

func _process(_delta):
	#camera.apply_shake()
	var rocket_velocity = round(rocket.linear_velocity.y)
	var time_left = timer.time_left
	var rocket_fuel = rocket.fuel
	hud.update_stats(rocket_velocity, time_left, rocket_fuel)
