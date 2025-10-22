extends CharacterBody2D

var direction
var ydirection
var lastDirection = 0

const SPEED = 600.0
const JUMP_VELOCITY = -1000.0
const DASH_VELOCITY = 1000
const DASH_TIME = .3


var attacking = false
var ChargingAttack = false
var windingUp = false
var attackBuffer = false

var windUpTimeMin = .5
var windUpTimeMax = .7
var chargeTime = .4
var attackTime = .3
var chargeAttackTime = .3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func move(delta) -> void:
	if direction:
		velocity.x = lerp(velocity.x, direction * SPEED, delta * 10)
		$Sprite2D.scale.x = direction * .25
		lastDirection = direction
	else:
		velocity.x = lerp(velocity.x, 0.0, delta * 20)
	if $Timers/Dash.time_left > 0:
		velocity.x = DASH_VELOCITY * lastDirection
		velocity.y = 0

func camera(delta) -> void:
	$"../Camera2D".position.x = lerp($"../Camera2D".position.x, position.x , delta * 5)
	$"../Camera2D".position.y = lerp($"../Camera2D".position.y, position.y , delta * 2)



func dashStart() -> void:
	velocity.x = DASH_VELOCITY * lastDirection
	velocity.y = 0
	$Timers/Dash.start(DASH_TIME)

func startWindUp() -> void:
	$Timers/Windup.start(windUpTimeMax)
	$AnimationPlayer.play("Winudp")
	windingUp = true

func startAttack() -> void:
	$Timers/Attack.start(attackTime)
	attacking = true
	$AnimationPlayer.play("new_animation")
	print("Attack!")
	
func startChargeAttack() -> void:
	$Timers/Attack.start(chargeAttackTime)
	attacking = true
	
	velocity.x = -700 * direction
	velocity.y = -1000 * ydirection
	
	print("Charge!")

func windUp() -> void:
	if attackBuffer == true:
	
		if $Timers/Windup.time_left <= chargeTime:
			attackBuffer = false
			$AnimationPlayer.stop()
			startChargeAttack()
			windingUp = false
			
		elif  $Timers/Windup.time_left <= windUpTimeMin:
			attackBuffer = false
			$AnimationPlayer.stop()
			startAttack()
			windingUp = false
		
	if $Timers/Windup.time_left == 0:
		$AnimationPlayer.stop()
		startChargeAttack()
		windingUp = false
	
		
		

func attack() -> void:
	if $Timers/Attack.time_left > 0 or not $Timers/Attack.is_stopped():
		$Hitbox.monitoring = true
		$Hitbox.position = Vector2(130 * direction, 130 * y sdds adirection)
	else:
		$Hitbox.monitoring = false
		$Hitbox.position = Vector2(0,0)
	







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
	
	#move
	move(delta)
	
	
	#Start Dash
	if Input.is_action_just_pressed("Dash"):
		dashStart()
	
	#Dash Cancel
	if Input.is_action_just_released("Dash"):
		$Timers/Dash.stop()
		
	#Attack
	if Input.is_action_just_pressed("Attack"):
		startWindUp()
	
	if Input.is_action_just_released("Attack"):
		if windingUp == true:
			attackBuffer = true
	
	if windingUp == true:
		windUp()
		
	if attacking == true:
		attack()
	
	move_and_slide()
	camera(delta)
	
