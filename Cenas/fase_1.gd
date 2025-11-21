extends Node

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	$CanvasLayer/ColorRect.hide()

func _on_area_2d_body_entered(_body: Node2D) -> void:
	$CanvasLayer/ColorRect.show()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Cenas/fase_2.tscn")
