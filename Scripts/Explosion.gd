extends AnimatedSprite

func _ready():
	frame = 0
	play("hitEffect")
	

func _on_Explosion_animation_finished():
	queue_free()
