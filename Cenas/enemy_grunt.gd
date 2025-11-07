extends Enemy

class_name Grunt



func _on_body_entered(_body: Node2D) -> void:
	super.die()
