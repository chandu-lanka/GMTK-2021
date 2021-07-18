extends Node

var player = null
var player_2 = null
var node_creation_parent = null
var score = 0
var player_hp = 3
var player_2_hp = 3
var camera = null
var player_is_dead = false
var player_2_is_dead = false

func _physics_process(delta):
	if player_is_dead == true and player_2_is_dead == true:
		get_tree().change_scene("res://Scenes/Dead.tscn")

func instance_node(node, location, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance
