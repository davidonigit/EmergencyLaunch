extends Node2D
@onready var camera = $Rocket/Camera2D
@onready var label = $HUD/Label
@onready var rocket = $Rocket


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#camera.apply_shake()
	label.text = "VELOCIDADE:\n"+str(rocket.linear_velocity)
