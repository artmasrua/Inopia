extends Sprite2D


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/fase_01.tscn");

func _on_button_2_pressed() -> void:
	get_tree().quit();
	
