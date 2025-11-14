extends Area2D

class_name Enemy

@export var h_speed = 20.0
@export var v_speed = 100.0
@onready var ray_cast_2d = $RayCast2D
@onready var animated_sprite_2d = $AnimatedSprite2D
var direcao = true # se for true vai para a esquerda, se for false, vai para a direita
 
func _process(delta):
	if $RayCast2D2.is_colliding() and $AnimatedSprite2D.flip_h == true:
		$RayCast2D2.target_position = Vector2(16,0)
		$AnimatedSprite2D.flip_h = false
	
	elif $RayCast2D2.is_colliding() and $AnimatedSprite2D.flip_h == false:
		$RayCast2D2.target_position = Vector2(-16,0)
		$AnimatedSprite2D.flip_h = true
	
	if $AnimatedSprite2D.flip_h == true:
		position.x -= h_speed * delta
	else:
		position.x += h_speed * delta
	

	if !ray_cast_2d.is_colliding():
		position.y += v_speed * delta

func die():
	h_speed = 0
	v_speed = 0
	animated_sprite_2d.play("dead")
