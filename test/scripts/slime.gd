extends Node2D

var can_damage = true


	
func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.name == "Player" and can_damage:
		can_damage = false
		body.take_damage(1)
		
		await get_tree().create_timer(1.0).timeout
		can_damage = true
