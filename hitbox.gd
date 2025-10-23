extends Area2D

var already_hit = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _handleHit(Enemy) -> void:
	var direction = -Vector2(Enemy.position.x - $"..".position.x, 0).normalized().x
	Enemy.Health -= $"..".attackDamage
	Enemy.Stunned = true
	Enemy.velocity = Vector2(-direction, -1) * 1000/Enemy.scale.x
	Enemy.get_node("Timers/Stun").start(.3)
	Enemy.move_and_slide()
	print(Enemy.Health)
	print("HIT!!")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(monitorable)
	if monitoring == true:
		var overlaps = get_overlapping_areas()
		for i in overlaps:
			if not already_hit.has(i): #Not Already hit by hitbox
				already_hit.append(i)
				
				
				
				_handleHit(i.get_parent())
				#i.get_parent().move_and_slide()

	else:
		already_hit.clear()	
		#print(monitoring)
	


func _on_area_entered(area: Area2D) -> void:
	print("afgtwrqfw")
