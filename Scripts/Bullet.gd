extends KinematicBody2D

export var speed = 500
var direction = Vector2.ZERO

func _physics_process(delta):
	move_and_collide(direction * speed * delta)
	
func _on_HitBox_body_entered(body):
	if body.name == "TileMap":
		queue_free()
