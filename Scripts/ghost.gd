extends Sprite

func _ready():
	$Tween.interpolate_property(self, "modulate", Color(1, 0.584314, 0), Color(0,0,0,0), .6, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	queue_free()
