extends Node

var player_proximo = false

func _on_minerio_area_body_entered(_body: Node2D) -> void:
	$Minerio/Minerio/Exclamation.show()
	player_proximo = true

func _process(_delta):
	if Input.is_action_just_pressed("interagir") && player_proximo:
		$player_rato.speed = 0
		$player_rato.jump_velocity = 0
		$CanvasLayer/Tela_final.show()


func _on_minerio_area_body_exited(_body: Node2D) -> void:
	$Minerio/Minerio/Exclamation.hide()
	player_proximo = false
