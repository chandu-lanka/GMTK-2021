extends Control

var tips = ["Don't Shoot Too Much, You might crash with the other triangle", "Don't Shoot Less Often, You Will Seperate", "Try to Use Walls To Get Close Enough", "Red Square Likes Orange Triangle", "Blue Circle Likes Yellow Triangle"]

var rand_num = int(rand_range(1,5))

func _ready():
	print(rand_num)
	$Tips.text = tips[rand_num]

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Levels/Arena.tscn")
