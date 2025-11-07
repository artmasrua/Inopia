extends Area2D

class_name Enemy

@export var h_speed = 20.0
@export var v_speed = 100.0
@onready var ray_cast_2d = $RayCast2D
@onready var animated_sprite_2d = $AnimatedSprite2D
 
func _process(delta):
	position.x -= h_speed * delta
	if !ray_cast_2d.is_colliding():
		position.y += v_speed * delta

func die():
	h_speed = 0
	v_speed = 0
	animated_sprite_2d.play("dead")
