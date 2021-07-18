extends KinematicBody2D


export var acceleration = 300
export var max_speed = 600
export var friction = 600

export var BulletScene : PackedScene

var velocity = Vector2.ZERO
onready var player_1 = get_parent().get_node("Triangle")
onready var explosion = preload("res://Scenes/Explosion.tscn")
var hp = 3

func _ready():
	Global.player_2 = self
	
func _exit_tree():
	Global.player_2 = null

func _physics_process(delta):
	if Global.player_2_is_dead == false:
		look_at(get_global_mouse_position())
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		input_vector.normalized()
		
		if input_vector != Vector2.ZERO:
			velocity += input_vector * acceleration * delta
			velocity = velocity.clamped(max_speed * delta)
		else:
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
		if hp <= 0:
			Global.player_2_is_dead = true
			queue_free()
			var ex = Global.instance_node(explosion, global_position, get_parent())
			ex.scale = Vector2(6,6)
		
		move_and_collide(velocity)
		
func _unhandled_input(event):
	if event.is_action_pressed("fire"):
		position.x = position.x - 10
		$SplitTimer.start()
		$Shoot.play()
		var bullet = BulletScene.instance() as Node2D
		get_parent().add_child(bullet)
		bullet.direction = (get_global_mouse_position() - global_position).normalized()
		bullet.global_position = $Position2D.global_position
		bullet.modulate = Color("f7ff00")
		bullet.rotation = bullet.direction.angle()
	

func _on_SplitTimer_timeout():
	position.x = position.x + 50


func _on_HitBox_area_entered(area):
	if area.is_in_group("enemy"):
		hp -= 1
		Global.instance_node(explosion, global_position, get_parent())
	if area.is_in_group("triangle-1"):
		queue_free()
		get_tree().change_scene("res://Scenes/Dead.tscn")
		Global.instance_node(explosion, global_position, get_parent())
