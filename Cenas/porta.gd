extends Node2D

func _ready():
	# Buscar o puzzle e conectar o sinal
	var puzzle = get_parent()  # O puzzle é pai da porta
	if puzzle:
		print("Conectando sinal do puzzle na porta")
		puzzle.puzzle_solved.connect(_on_puzzle_solved)
	else:
		print("ERRO: Puzzle não encontrado como pai da porta")

func _on_puzzle_solved(resultado):
	print("🎯 PORTA: Puzzle resolvido! Resultado: ", resultado)
	abrir_porta()

func abrir_porta():
	print("🚪 Iniciando abertura da porta...")
	
	# Referência ao AnimatableBody2D (que tem a colisão)
	var corpo_porta = $AnimatableBody2D
	var sprite_porta = $AnimatableBody2D/sprite_porta
	
	if corpo_porta and sprite_porta:
		print("✅ Componentes da porta encontrados")
		
		# Opção A: Desativar colisão e esconder (mais simples)
		#corpo_porta.get_node("CollisionShape2D").disabled = true
		#sprite_porta.hide()
		#print("Porta aberta (colisão desativada)")
		
		# Opção B: Mover a porta para cima (para porta vertical)
		var tween = create_tween()
		tween.tween_property(corpo_porta, "position", corpo_porta.position - Vector2(0, 135), 1.0)
		print("Porta está se movendo para cima")
	else:
		print("❌ ERRO: Componentes da porta não encontrados")
