extends Control

@onready var animation_player = $AnimationPlayer


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game/game.tscn")


func _on_tutorial_pressed():
	animation_player.play('initial_to_tutorial')


func _on_quit_pressed():
	get_tree().quit()


func _on_credits_pressed():
	animation_player.play("initial_to_credits")


func _on_credits_to_initial_pressed():
	animation_player.play("credits_to_initial")
	


func _on_tutorial_to_initial_pressed():
	animation_player.play("tutorial_to_initial")





