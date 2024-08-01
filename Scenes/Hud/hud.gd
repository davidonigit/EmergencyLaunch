extends CanvasLayer

@onready var velocity_label = $Velocity/VelocityLabel
@onready var time_left_label = $TimeLeft/TimeLeftLabel
@onready var fuel_bar = $FuelBar

@onready var hight_label = $Hight/HightLabel
@onready var body_label = $GameoverPanel/VBoxContainer/BodyLabel
@onready var game_over_label = $GameoverPanel/VBoxContainer/GameOver
@onready var reached_hight_label = $GameoverPanel/VBoxContainer/ReachedHight
@onready var gameover_panel = $GameoverPanel
@onready var highscore_label = $GameoverPanel/VBoxContainer/Highscore


func update_stats(velocity, time, fuel, hight):
	velocity_label.text = str(-velocity)
	time_left_label.text = str(time).pad_decimals(2)
	fuel_bar.value = fuel
	hight_label.text = str(hight)


func gameover_menu(hight:int, ground_hit:bool):
	gameover_panel.show()
	if ground_hit:
		game_over_label.text = 'GAME OVER'
		body_label.text = 'you hit the ground!'
		reached_hight_label.text = '0 meters'
		highscore_label.hide()
	else:
		if hight < 100:
			body_label.text = 'danger explosion hight'
		elif hight < 3000:
			body_label.text = 'bad explosion hight'
		elif hight < 8000:
			body_label.text = 'good explosion hight'
		elif hight < 15000:
			body_label.text = 'great explosion hight'
		else:
			body_label.text = 'amazing explosion hight'
			
		game_over_label.text = 'GAME OVER'
		reached_hight_label.text = str(hight)+' meters'
		if GameController.test_highscore(hight):
			highscore_label.show()
		else:
			highscore_label.hide()

func _on_try_again_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game/game.tscn")


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")
