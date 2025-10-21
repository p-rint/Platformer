extends Area2D

var already_hit = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _handleHit(Enemy) -> void:
	Enemy.Health -= 10
	Enemy.Stunned = true
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
