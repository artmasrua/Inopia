extends Node2D

@onready var corpo_porta = $AnimatableBody2D
var porta_aberta: bool = false

func _ready():
	var puzzle2 = get_parent()
	
	if puzzle2 and puzzle2.has_signal("puzzle_solved"):
		puzzle2.puzzle_solved.connect(_on_puzzle2_solved)
	else:
		print("❌ ERRO: Não consegui conectar a porta ao Puzzle2")

func _on_puzzle2_solved():
	abrir_porta()

func abrir_porta():
	if porta_aberta:
		return
	
	porta_aberta = true
	
	if corpo_porta:
		var tween = create_tween()
		tween.tween_property(corpo_porta, "position", corpo_porta.position - Vector2(0, 120), 1.0)
		tween.tween_callback(_on_porta_aberta_completo)
	else:
		print("❌ AnimatableBody2D não encontrado")

func _on_porta_aberta_completo():
	var collision = corpo_porta.get_node("CollisionShape2D")
	if collision:
		collision.disabled = true
