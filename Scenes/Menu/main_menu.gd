extends Control

func _ready():
	pass


func _process(_delta):
	pass


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game/game.tscn")


func _on_quit_pressed():
	get_tree().quit()
