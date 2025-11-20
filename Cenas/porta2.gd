extends Node2D

@onready var corpo_porta = $AnimatableBody2D
var porta_aberta: bool = false

func _ready():
	# Buscar o Puzzle2
	var puzzle2 = get_parent()  # Se a porta for filha do Puzzle2
	
	if puzzle2 and puzzle2.has_signal("puzzle_solved"):
		puzzle2.puzzle_solved.connect(_on_puzzle2_solved)
		print("✅ Porta 2 conectada ao Puzzle2")
	else:
		print("❌ ERRO: Não consegui conectar a porta ao Puzzle2")

func _on_puzzle2_solved():
	print("🎯 PORTA 2: Puzzle2 resolvido! Movendo porta...")
	abrir_porta()

func abrir_porta():
	if porta_aberta:
		return
	
	porta_aberta = true
	print("🚪 Movendo porta do Puzzle2...")
	
	if corpo_porta:
		# Criar animação para mover a porta para cima
		var tween = create_tween()
		tween.tween_property(corpo_porta, "position", corpo_porta.position - Vector2(0, 120), 1.0)
		tween.tween_callback(_on_porta_aberta_completo)
		print("✅ Animação de movimento iniciada")
	else:
		print("❌ AnimatableBody2D não encontrado")

func _on_porta_aberta_completo():
	print("🎉 PORTA 2 completamente aberta!")
	# Opcional: desativar colisão depois de mover
	var collision = corpo_porta.get_node("CollisionShape2D")
	if collision:
		collision.disabled = true
