extends Node

var resposta_certa = 35

var valor_azul = 0
var valor_amarelo = 0



func _on_area_2d_body_entered(_body: Node2D) -> void:
	get_tree().change_scene_to_file("res://Cenas/fase_2.tscn")
