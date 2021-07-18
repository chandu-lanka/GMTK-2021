extends Node2D

var amplitude = 0
var priority = 0
const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

onready var camera = get_parent()

func start(duration = 0.2, frequency = 15, amp = 16, pri = 0):
	if pri >= self.priority:
		self.priority = pri
		self.amplitude = amp
		
		$Duration.wait_time = duration
		$Frequency.wait_time = 1 / float(frequency)
		
		$Duration.start()
		$Frequency.start()
		
		new_shake()

func new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
	
	$ShakeTween.interpolate_property(camera, "offset", camera.offset,rand, $Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()

func reset():
	$ShakeTween.interpolate_property(camera, "offset", camera.offset,Vector2(), $Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()
	priority = 0

func _on_Frequency_timeout():
	new_shake()
	$Frequency.stop()
