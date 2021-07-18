extends KinematicBody2D

var speed = 400
var velocity = Vector2.ZERO
var stun = false

var hp = 5

onready var explosion = preload("res://Scenes/Explosion.tscn")

func _process(delta):
	$HP.text = str(hp)
	if Global.player_2 != null and stun == false:
		velocity = global_position.direction_to(Global.player_2.global_position)
	if stun:
		velocity = lerp(velocity, Vector2(0,0), 0.3)
	
	if hp <= 0:
		Global.score += 1
		if Global.node_creation_parent != null:
			var ex = Global.instance_node(explosion, global_position, Global.node_creation_parent)
			ex.scale = Vector2(6,6)
		queue_free()
		
	global_position += velocity * speed * delta
	


func _on_HitBox_area_entered(area):
	if area.is_in_group("bullet") and stun == false:
		stun = true
		get_parent().get_node("Camera2D/ScreenShake").start(.2, 6, 8)
		hp -= 1
		$Hit.play()
		$HP.text = str(hp)
		velocity = -velocity * 4
		var explosion_fx = explosion.instance()
		add_child(explosion_fx)
		explosion_fx.global_position = global_position
		$StunTimer.start()
		area.get_parent().queue_free()


func _on_StunTimer_timeout():
	stun = false

func _on_ExplosionTimer_timeout():
	queue_free()
