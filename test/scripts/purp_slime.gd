extends Node2D

const SPEED = 60

var direction = 1
var can_damage = true

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	
	position.x += direction * SPEED * delta


func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.name == "Player" and can_damage:
		can_damage = false
		body.take_damage(1)
		
		await get_tree().create_timer(1.0).timeout
		can_damage = true
