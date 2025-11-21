extends Node

func _on_play_pressed() -> void: #Iniciar o jogo (Passar para próxima cena)
	get_tree().change_scene_to_file("res://Cenas/cutscene.tscn");

func _on_quit_pressed() -> void: #Fechar o jogo
	get_tree().quit();

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/tela_creditos.tscn")
