extends AnimatedSprite2D

func trigger_animation(velocity: Vector2, direction: int):
	

	if not get_parent().is_on_floor():
		play("jump")
	elif velocity.x != 0:
		play("walk")
	else: play("stop")
