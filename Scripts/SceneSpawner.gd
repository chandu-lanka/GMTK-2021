extends Node2D

var enemy = preload("res://Scenes/Enemy.tscn")
var enemy_2 = preload("res://Scenes/Enemy-2.tscn")

func _ready():
	$CanvasLayer/Control/Label.text = str(Global.score)

func _physics_process(_delta):
	$CanvasLayer/Control/Label.text = str(Global.score)

func _on_SpawnerTimer_timeout():
	var enemy_pos_1 = Vector2(rand_range(-160, 670), rand_range(-90, 390))
	var enemy_pos_2 = Vector2(rand_range(-130, 640), rand_range(-60, 360))
	
	while enemy_pos_1.x < 640 and enemy_pos_1.x > -80 and enemy_pos_1.y < 360 and enemy_pos_1.y > -45:
		enemy_pos_1 = Vector2(rand_range(-160, 670), rand_range(-90, 390))
		
	while enemy_pos_2.x < 610 and enemy_pos_2.x > -80 and enemy_pos_2.y < 330 and enemy_pos_2.y > -45:
		enemy_pos_2 = Vector2(rand_range(-160, 670), rand_range(-90, 390))
		
	Global.instance_node(enemy, enemy_pos_1, self)
	Global.instance_node(enemy_2, enemy_pos_2, self)
