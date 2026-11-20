extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -700.0
const gravity = 2

var animation = 0

#misc timers
var idleTimer = 0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	
	if is_on_floor():
		idleTimer = idleTimer+delta
		if idleTimer>0.5:
			print("yea")
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("still(placeholder)")
	else:
		print("yea")
		$AnimatedSprite2D.play("still(placeholder)")
	
	print(idleTimer)
	
	if not is_on_floor():
		idleTimer=0
		velocity += get_gravity() * delta * gravity

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		idleTimer=0
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		idleTimer=0
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
