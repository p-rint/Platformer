extends CharacterBody2D

var direction
var ydirection

const SPEED = 600.0
const JUMP_VELOCITY = -1000.0
const DASH_VELOCITY = 1000
const DASH_TIME = .3

var lastDirection = 0
var attacking = false
var ChargingAttack = false
var windingUp = false

var windUpTimeMin = .5
var windUpTimeMax = .7
var chargeTime = .3
var attackTime = .3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func dashStart() -> void:
	lastDirection = direction
	velocity.x = DASH_VELOCITY * lastDirection
	velocity.y = 0
	$Timers/Dash.start(DASH_TIME)

func startWindUp() -> void:
	$Timers/Windup.start(windUpTimeMax)
	$AnimationPlayer.play("Winudp")

func startAttack() -> void:
	$Timers/Attack.start(attackTime)
	attacking = true

func windUp() -> void:
	if $Timers/Windup.time_left == 0 or $Timers/Windup.is_stopped():
		startAttack()
		

func Attack() -> void:
	if $Timers/Attack.time_left > 0 or not $Timers/Attack.is_stopped():
		$Hitbox.monitoring = true
	else:
		$Hitbox.monitoring = false






# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	direction = Input.get_axis("Left", "Right")
	ydirection = Input.get_axis("Up", "Down")
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() == true:
		velocity.y = JUMP_VELOCITY
	#Jump Cancel
	if Input.is_action_just_released("ui_accept") and is_on_floor() == false:
		velocity.y = max(velocity.y, -600)
	
	#Start Dash
	if Input.is_action_just_pressed("Dash"):
		dashStart()
	
	#Dash Cancel
	if Input.is_action_just_released("Dash"):
		$Timers/Dash.stop()
		
	#Attack
	if Input.is_action_just_pressed("Attack"):
		startWindUp()
	
	if windingUp = true:
		
	
	
