extends CharacterBody2D

var direction
var ydirection

const SPEED = 400.0
const JUMP_VELOCITY = -1000.0
const DASH_VELOCITY = 1000
const DASH_TIME = .3

func _ready() -> void:
	pass

@export var Health = 100 * (scale.x)
@export var Stunned = false
var lastDirection = 0
@onready var player = $"../../CharacterBody2D"

func move(delta) -> void:
	velocity.x = lerp(velocity.x, direction * (SPEED/scale.x), delta * 10)
	$Sprite2D.scale.x = direction * .25


func _physics_process(delta: float) -> void:
	direction = -Vector2(position.x - player.position.x, 0).normalized().x
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if $Timers/Stun.time_left > 0:
		$Sprite2D.skew = lerpf($Sprite2D.skew,.5, delta* 10)
	else:
		$Sprite2D.skew = lerpf($Sprite2D.skew,0, delta * 7)
		if position.distance_to(player.position) <= 1000:
			move(delta)
	
	
	move_and_slide()
	if Health <= 0:
		queue_free()
	
