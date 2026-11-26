extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -800.0
const gravity = 2

var animation = ""

#for the land animation
var lastFrameUp = 0

#which direction was pressed last
var lastDirection = "right"

#misc timers
var idleTimer = 0
var jumpTimer = 1
var landTimer = 0


func _physics_process(delta: float) -> void:
	
	#print(velocity.y)
	
	# Add the gravity.
	if $AnimatedSprite2D.animation == "jump":
		if $AnimatedSprite2D.frame ==1:
			$AnimatedSprite2D.pause()
	#print($AnimatedSprite2D.animation)
	
	#timers:
	jumpTimer = jumpTimer + delta
	landTimer = landTimer + delta
	if is_on_floor():
		idleTimer = idleTimer+delta
		if lastFrameUp == 1:
			landTimer = 0
	
	if is_on_floor():
		animation = "still(placeholder)"
		if idleTimer>0.5:
			$AnimatedSprite2D.play("idle")
		else:
			anim()
	else:
		animation = "jump"
		anim()
	
	#print(idleTimer)
	
	if not is_on_floor():
		lastFrameUp = 1
		idleTimer=0
		velocity += get_gravity() * delta * gravity
	else:
		lastFrameUp = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		idleTimer=0
		jumpTimer=0
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("ui_left"):
		lastDirection="left"
	if Input.is_action_just_pressed("ui_right"):
		lastDirection="right"
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		idleTimer=0
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	#print(jumpTimer)
	
func anim():
	$AnimatedSprite2D.pause()
	if animation == "jump":
		if jumpTimer > 0.1:
			$AnimatedSprite2D.animation ="jump"
			if lastDirection == "left":
				if velocity.y<0:
					$AnimatedSprite2D.frame = 2
				elif velocity.y<300:
					$AnimatedSprite2D.frame = 6
				elif velocity.y<900:
					$AnimatedSprite2D.frame = 8
				else:
					$AnimatedSprite2D.frame = 4
			if lastDirection == "right":
				if velocity.y<0:
					$AnimatedSprite2D.frame = 1
				elif velocity.y<300:
					$AnimatedSprite2D.frame = 5
				elif velocity.y<900:
					$AnimatedSprite2D.frame = 7
				else:
					$AnimatedSprite2D.frame = 3
		else:
			$AnimatedSprite2D.animation ="jump"
	elif landTimer < 0.1:
		$AnimatedSprite2D.animation ="jump"
		$AnimatedSprite2D.frame = 0
	else:
		$AnimatedSprite2D.animation="still(placeholder)"
