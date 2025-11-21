extends Node2D

signal puzzle_solved

# Referência para a porta
@onready var porta = $porta

# Variável para armazenar a alavanca ativa
var alavanca_ativa = null

func _ready():
	print("💰 Puzzle das Moedas inicializado")
	print("Resposta correta: 18 moedas")
	
	# Conectar todas as alavancas brancas
	for child in get_children():
		if child.is_in_group("alavancas_brancas"):
			print("Conectando alavanca: ", child.name, " | Valor: ", child.numero_alavanca)
			child.connect("alavanca_ativada", _on_alavanca_ativada)
			child.connect("alavanca_desativada", _on_alavanca_desativada)

func _on_alavanca_ativada(cor, numero):
	print("Alavanca ativada - Valor: ", numero)
	
	# Se já tinha uma alavanca ativa, desativa ela
	if alavanca_ativa != null and alavanca_ativa != numero:
		for child in get_children():
			if child.is_in_group("alavancas_brancas") and child.numero_alavanca == alavanca_ativa:
				child.desativar()
				break
	
	# Ativar nova alavanca
	alavanca_ativa = numero
	verificar_solucao()

func _on_alavanca_desativada(cor, numero):
	print("Alavanca desativada: ", numero)
	
	if alavanca_ativa == numero:
		alavanca_ativa = null

func verificar_solucao():
	print("Verificando solução... Alavanca ativa: ", alavanca_ativa)
	
	# Resposta correta: 18 moedas
	if alavanca_ativa == 18:
		print("🎉 PUZZLE RESOLVIDO! 10 cristais × 3 = 30, 30 - 12 = 18 ✅")
		puzzle_solved.emit()
		abrir_porta()
	else:
		print("❌ Resposta incorreta. Tente novamente!")

func abrir_porta():
	print("🚪 Abrindo porta...")
	# Animação ou lógica para abrir a porta
	if porta and porta.has_method("abrir"):
		porta.abrir()
	else:
		# Fallback: desativar colisão e esconder
		var collision = porta.get_node_or_null("CollisionShape2D")
		if collision:
			collision.disabled = true
		var sprite = porta.get_node_or_null("Sprite2D")
		if sprite:
			sprite.hide()

# Função para resetar o puzzle
func resetar_puzzle():
	alavanca_ativa = null
	for child in get_children():
		if child.is_in_group("alavancas_brancas") and child.has_method("resetar"):
			child.resetar()
