extends Node2D

func _ready():
	var puzzle = get_parent()
	if puzzle:
		puzzle.puzzle_solved.connect(_on_puzzle_solved)
	else:
		print("ERRO: Puzzle não encontrado como pai da porta")

func _on_puzzle_solved(_resultado):
	abrir_porta()

func abrir_porta():
	
	var corpo_porta = $AnimatableBody2D
	var sprite_porta = $AnimatableBody2D/sprite_porta
	
	if corpo_porta and sprite_porta:

		var tween = create_tween()
		tween.tween_property(corpo_porta, "position", corpo_porta.position - Vector2(0, 135), 1.0)
		print("Porta está se movendo para cima")
	else:
		print("❌ ERRO: Componentes da porta não encontrados")
