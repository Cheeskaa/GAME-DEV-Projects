extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_body_entered(body: Node2D) -> void:
	print("+1 point!")
	GameManager.add_score()
	animation_player.play("Pickup")
