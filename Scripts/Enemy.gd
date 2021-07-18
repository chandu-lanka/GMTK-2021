extends KinematicBody2D

var speed = 200
var velocity = Vector2.ZERO
var stun = false
var hp = 3
var explosion = preload("res://Scenes/Explosion.tscn")

func _process(delta):
	$HP.text = str(hp)
	if Global.player != null and stun == false:
		velocity = global_position.direction_to(Global.player.global_position)
	if stun:
		velocity = lerp(velocity, Vector2(0,0), 0.3)
	
	if hp <= 0:
		Global.score += 1
		queue_free()
		
	global_position += velocity * speed * delta

func _on_HitBox_area_entered(area):
	if area.is_in_group("bullet"):
		stun = true
		hp -= 1
		$Hit.play()
		get_parent().get_node("Camera2D/ScreenShake").start(.2, 6, 8)
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
