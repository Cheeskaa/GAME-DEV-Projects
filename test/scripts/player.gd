extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -250.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: TextureProgressBar = $"../HUD/HealthBar"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var max_health = 10
var health = 10
var is_dead = false
var is_hit = false


func _ready():
	health_bar.max_value = max_health
	health_bar.value = health


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_hit:
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")

	if not is_hit:
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true

		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
		else:
			animated_sprite.play("jump")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func take_damage(amount):
	if is_dead or is_hit:
		return

	is_hit = true
		
	health -= amount
	animation_player.play("hurt" )
	print("Health:", health)

	health_bar.value = health

	if health <= 0:
		die()
		return

	animated_sprite.play("hit")

	await animated_sprite.animation_finished

	is_hit = false


func die():
	is_dead = true
	velocity = Vector2.ZERO
	animated_sprite.play("die")

	GameManager.score = 0
	
	await animated_sprite.animation_finished
	get_tree().reload_current_scene()
