extends MeshInstance3D

var speed := 2.0

func _process(delta):
	position.x += speed * delta
	if position.x > 3:
		position.x = -3
