extends Node2D

signal puzzle_solved

@onready var porta = $porta 

var valor_azul = null
var valor_vermelho = null
var valor_amarelo = null

@onready var label_azul: Label = $num_azul
@onready var label_vermelha: Label = $num_vermelho
@onready var label_amarela: Label = $num_amarelo

func _ready():
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
	

func conectar_alavancas_recursivamente(node: Node):
	var alavancas_conectadas = 0
	
	for child in node.get_children():
		if child is AnimatedSprite2D:
			
			if child.has_method("alternar_alavanca") and child.has_signal("alavanca_ativada"):
				
				if child.is_connected("alavanca_ativada", _on_alavanca_ativada):
					child.disconnect("alavanca_ativada", _on_alavanca_ativada)
				if child.is_connected("alavanca_desativada", _on_alavanca_desativada):
					child.disconnect("alavanca_desativada", _on_alavanca_desativada)
				
				child.connect("alavanca_ativada", _on_alavanca_ativada)
				child.connect("alavanca_desativada", _on_alavanca_desativada)
				alavancas_conectadas += 1
		
		if child.get_child_count() > 0:
			alavancas_conectadas += conectar_alavancas_recursivamente(child)
	
	return alavancas_conectadas

func _on_alavanca_ativada(cor, numero):
	
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
	
	# Verificar se todas as alavancas estão ativas
	if valor_azul == null or valor_vermelho == null or valor_amarelo == null:
		return
	
	
	var equacao1 = (valor_azul - valor_vermelho) == 6
	var equacao2 = (valor_azul - valor_amarelo) == 24
	var equacao3 = (valor_vermelho + 2) == 22
	var equacao4 = (valor_amarelo + 2) == 4
	
	
	if equacao1 and equacao2 and equacao3 and equacao4:
		puzzle_solved.emit()
	else:
		print("❌ Equações não batem")

func abrir_porta():
	
	if porta:
		
		var collision = _find_collision_shape(porta)
		if collision:
			collision.disabled = true
		else:
			print("❌ CollisionShape2D não encontrado em nenhum nível")
		
		var sprite = _find_sprite(porta)
		if sprite:
			sprite.hide()
		else:
			print("❌ Sprite2D não encontrado em nenhum nível")
		
	else:
		print("❌❌❌ PORTA É NULL!")

func _find_collision_shape(node: Node) -> CollisionShape2D:
	for child in node.get_children():
		if child is CollisionShape2D:
			return child
		var found = _find_collision_shape(child)
		if found:
			return found
	return null

func _find_sprite(node: Node) -> Sprite2D:
	for child in node.get_children():
		if child is Sprite2D:
			return child
		var found = _find_sprite(child)
		if found:
			return found
	return null
