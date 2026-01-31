extends Label3D

var radius := 3.0
var orbit_speed := 2.0
var spin_speed := 0.5
var angle := 0.0

func _process(delta):
	angle += orbit_speed * delta
	position.x = cos(angle) * radius
	position.z = sin(angle) * radius
	rotate_y(spin_speed * delta)
