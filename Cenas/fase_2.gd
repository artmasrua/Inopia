extends Node

func _on_area_2d_body_entered(_body: Node2D) -> void:
	pass
	$CanvasLayer/ColorRect.show()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Cenas/fase_3.tscn")
