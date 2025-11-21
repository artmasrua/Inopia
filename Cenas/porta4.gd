extends Node2D

@onready var corpo_porta = $AnimatableBody2D
var porta_aberta: bool = false

func _ready():
	# Buscar o puzzle pai e conectar o sinal
	var puzzle = get_parent()
	if puzzle and puzzle.has_signal("puzzle_solved"):
		puzzle.puzzle_solved.connect(_on_puzzle_solved)
		print("✅ Porta conectada ao puzzle")

func _on_puzzle_solved():
	print("🎯 Porta: Puzzle resolvido! Abrindo...")
	abrir()

func abrir():
	if porta_aberta:
		return
	
	porta_aberta = true
	print("🚪 Porta abrindo...")
	
	if corpo_porta:
		# Animação para mover a porta
		var tween = create_tween()
		tween.tween_property(corpo_porta, "position", corpo_porta.position - Vector2(0, 200), 1.0)
		tween.tween_callback(_on_porta_aberta_completo)
	else:
		# Fallback simples
		var collision = get_node_or_null("CollisionShape2D")
		if collision:
			collision.disabled = true
		var sprite = get_node_or_null("Sprite2D")
		if sprite:
			sprite.hide()

func _on_porta_aberta_completo():
	print("🎉 Porta completamente aberta!")
	var collision = corpo_porta.get_node_or_null("CollisionShape2D")
	if collision:
		collision.disabled = true
