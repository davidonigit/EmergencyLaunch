extends Node2D

@onready var pointer = $Pointer
@onready var hit_button = $FuelIcon
@onready var spawnpoints = $Spawnpoints

var last_spawn:int = -1
var rng = RandomNumberGenerator.new()
var index:int

signal refuel(value:int)


func _ready():
	respawn_button()

func _process(delta):
	pointer.rotation_degrees += 200 * delta
	if pointer.rotation_degrees >= 360:
		pointer.rotation_degrees = 0
	
	if Input.is_action_just_pressed("refuel"):
		check_hit(pointer.rotation_degrees)


func respawn_button():
	var same_index:bool = true
	while same_index:
		index = rng.randi_range(0,3)
		if index != last_spawn:
			same_index = false
			last_spawn = index
			
	hit_button.global_position = spawnpoints.get_child(index).global_position
	correct_hit_button_rotation()


func correct_hit_button_rotation():
	if index == 0 or index == 2:
		hit_button.rotation_degrees = 0
	if index == 1 or index == 3:
		hit_button.rotation_degrees = 90


func check_hit(p_rotation:float):
	var check:bool = false
	match index:
		0:
			if p_rotation >= 335 or p_rotation <= 25: 
				check = true
		1:
			if p_rotation >= 65 and p_rotation <= 115: 
				check = true
		2:
			if p_rotation >= 155 and p_rotation <= 205: 
				check = true
		3:
			if p_rotation >= 245 and p_rotation <= 295: 
				check = true
	if check:
		hit()
		
	else:
		miss()


func hit():
	$HitAudio.play()
	refuel.emit(10)
	respawn_button()


func miss():
	$MissAudio.play()
	refuel.emit(-5)
