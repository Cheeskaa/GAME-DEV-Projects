extends Area2D

@onready var level_text = $"../UI/LevelText"


func _on_body_entered(body: Node2D) -> void:
	print("Something entered:", body.name)

	if body.name == "Player": 
		print("Player reached level 2")
		level_text.visible = true
		await get_tree().create_timer(2.0).timeout
		level_text.visible = false
