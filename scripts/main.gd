extends Node2D
var room = 0
var lastpx = 0
var lastpy = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var px = $start/player.position.x
	var py
	if $start/player/AnimatedSprite2D.animation =="jump"&&$start/player/AnimatedSprite2D.frame==0:
		py = $start/player.position.y+10
	else:
		py = $start/player.position.y
	var a = 0.1
	px = lastpx*(a)+px*(1-(a))
	py = lastpy*(a)+py*(1-(a))
	$start/eiris.position.x=px
	$start/eiris.position.y=py
	lastpx = px
	lastpy = py
	pass
