extends Node2D

var timer = 0
#0 = no blink, 1 = slow blink, 2 = fast blink
#implementing later
var blinktype = 1

var blinking = false
var between = randf_range(0.5,8)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer = timer + delta
	if timer > between:
		blink()

func blink():
	timer = 0
	$AnimatedSprite2D.play()
	between = randf_range(0.5,8)
	
