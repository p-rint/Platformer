extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -1000.0
const DASH_VELOCITY = 1000
const DASH_TIME = .3

var lastDirection = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
	
