extends Node2D

signal puzzle_solved

@onready var porta = $porta  # ✅ Note o "p" minúsculo - confirme se é este o nome

# Variáveis para armazenar os valores ativos
var valor_azul = null
var valor_vermelho = null
var valor_amarelo = null

# Referências para as labels
@onready var label_azul: Label = $num_azul
@onready var label_vermelha: Label = $num_vermelho
@onready var label_amarela: Label = $num_amarelo

func _ready():
	print("🎯 PUZZLE INICIADO - Buscando componentes...")
	
	# Debug detalhado da porta
	print("🚪 DEBUG DA PORTA:")
	print("  Porta encontrada: ", porta != null)
	if porta:
		print("  Nome da porta: '", porta.name, "'")
		print("  Tipo: ", porta.get_class())
		
		# Verificar filhos da porta
		print("  Filhos da porta:")
		for i in range(porta.get_child_count()):
			var child = porta.get_child(i)
			print("    ", i, ": ", child.name, " | Tipo: ", child.get_class())
	else:
		print("❌ PORTA NÃO ENCONTRADA! Verifique o nome.")
	
	# Buscar e conectar alavancas recursivamente
	conectar_alavancas_recursivamente(self)
	
	print("🎯 Puzzle pronto - Aguardando interação")

func conectar_alavancas_recursivamente(node: Node):
	var alavancas_conectadas = 0
	
	for child in node.get_children():
		if child is AnimatedSprite2D:
			print("🎯 Alavanca encontrada: ", child.name)
			
			if child.has_method("alternar_alavanca") and child.has_signal("alavanca_ativada"):
				print("  ✅ Conectando...")
				
				# Desconectar primeiro para evitar duplicatas
				if child.is_connected("alavanca_ativada", _on_alavanca_ativada):
					child.disconnect("alavanca_ativada", _on_alavanca_ativada)
				if child.is_connected("alavanca_desativada", _on_alavanca_desativada):
					child.disconnect("alavanca_desativada", _on_alavanca_desativada)
				
				# Conectar sinais
				child.connect("alavanca_ativada", _on_alavanca_ativada)
				child.connect("alavanca_desativada", _on_alavanca_desativada)
				alavancas_conectadas += 1
		
		# Buscar recursivamente
		if child.get_child_count() > 0:
			alavancas_conectadas += conectar_alavancas_recursivamente(child)
	
	return alavancas_conectadas

func _on_alavanca_ativada(cor, numero):
	print("🎯 ALAVANCA ATIVADA - Cor: ", cor, " | Valor: ", numero)
	
	match cor:
		"azul":
			valor_azul = numero
		"vermelha":
			valor_vermelho = numero
		"amarela":
			valor_amarelo = numero
	
	atualizar_labels()
	verificar_solucao()

func _on_alavanca_desativada(cor, numero):
	print("🎯 ALAVANCA DESATIVADA - Cor: ", cor)
	
	match cor:
		"azul":
			valor_azul = null
		"vermelha":
			valor_vermelho = null
		"amarela":
			valor_amarelo = null
	
	atualizar_labels()

func atualizar_labels():
	if label_azul:
		label_azul.text = "?" if valor_azul == null else str(valor_azul)
	if label_vermelha:
		label_vermelha.text = "?" if valor_vermelho == null else str(valor_vermelho)
	if label_amarela:
		label_amarela.text = "?" if valor_amarelo == null else str(valor_amarelo)

func verificar_solucao():
	print("🔍 VERIFICANDO SOLUÇÃO:")
	print("  Azul: ", valor_azul, " | Vermelho: ", valor_vermelho, " | Amarelo: ", valor_amarelo)
	
	# Verificar se todas as alavancas estão ativas
	if valor_azul == null or valor_vermelho == null or valor_amarelo == null:
		print("⏳ Faltam alavancas...")
		return
	
	print("📊 Todas as alavancas ativas! Verificando equações...")
	
	# Verificar as equações:
	var equacao1 = (valor_azul - valor_vermelho) == 6
	var equacao2 = (valor_azul - valor_amarelo) == 24
	var equacao3 = (valor_vermelho + 2) == 22
	var equacao4 = (valor_amarelo + 2) == 4
	
	print("  Azul - Vermelho = 6 → ", valor_azul, " - ", valor_vermelho, " = ", valor_azul - valor_vermelho, " → ", equacao1)
	print("  Azul - Amarelo = 24 → ", valor_azul, " - ", valor_amarelo, " = ", valor_azul - valor_amarelo, " → ", equacao2)  
	print("  Vermelho + 2 = 22 → ", valor_vermelho, " + 2 = ", valor_vermelho + 2, " → ", equacao3)
	print("  Amarelo + 2 = 4 → ", valor_amarelo, " + 2 = ", valor_amarelo + 2, " → ", equacao4)
	
	if equacao1 and equacao2 and equacao3 and equacao4:
		print("🎉🎉🎉 PUZZLE RESOLVIDO!")
		print("✅ EMITINDO SINAL puzzle_solved...")
		puzzle_solved.emit()
		print("✅ Sinal emitido! Verificando se porta recebeu...")
	else:
		print("❌ Equações não batem")

func abrir_porta():
	print("🚪🔓 MÉTODO abrir_porta() CHAMADO!")
	
	if porta:
		print("✅ Porta encontrada, abrindo...")
		
		# Método 1: Procurar CollisionShape2D em qualquer lugar
		var collision = _find_collision_shape(porta)
		if collision:
			collision.disabled = true
			print("✅ CollisionShape2D desativado")
		else:
			print("❌ CollisionShape2D não encontrado em nenhum nível")
		
		# Método 2: Procurar Sprite2D em qualquer lugar
		var sprite = _find_sprite(porta)
		if sprite:
			sprite.hide()
			print("✅ Sprite2D escondido")
		else:
			print("❌ Sprite2D não encontrado em nenhum nível")
		
		print("🎉 PORTA DEVERIA ESTAR ABERTA!")
	else:
		print("❌❌❌ PORTA É NULL!")

# Função para encontrar CollisionShape2D recursivamente
func _find_collision_shape(node: Node) -> CollisionShape2D:
	for child in node.get_children():
		if child is CollisionShape2D:
			return child
		# Buscar recursivamente
		var found = _find_collision_shape(child)
		if found:
			return found
	return null

# Função para encontrar Sprite2D recursivamente
func _find_sprite(node: Node) -> Sprite2D:
	for child in node.get_children():
		if child is Sprite2D:
			return child
		# Buscar recursivamente
		var found = _find_sprite(child)
		if found:
			return found
	return null

# TESTE MANUAL - Pressione Home para forçar a abertura
func _input(event):
	if event.is_action_pressed("ui_home"):
		print("🧪 TESTE MANUAL: Forçando abertura da porta")
		abrir_porta()
