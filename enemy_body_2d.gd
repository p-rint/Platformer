extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -1000.0
const DASH_VELOCITY = 1000
const DASH_TIME = .3

@export var Health = 100
@export var Stunned = false
var lastDirection = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if $Timers/Stun.time_left > 0:
		$Sprite2D.skew = .3
	else:
		$Sprite2D.skew = 0
	
	move_and_slide()
	
