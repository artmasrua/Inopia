extends ProgressBar

@export var player_rato = CharacterBody2D

signal die

func _ready() -> void:
	value = player_rato.current_hp

func _on_player_cure() -> void:
	value += 20

func _on_player_rato_dano() -> void:
	player_rato.current_hp -= 20
	value = player_rato.current_hp
	if value <= 0:
		emit_signal("die")
