extends Node2D

signal puzzle_solved(resultado_calculado)

var alavancas_azuis_ativas = []
var alavancas_amarelas_ativas = []
@export var numero_da_porta: int = 35

# Vamos buscar as labels manualmente sem @onready
var label_azul
var label_amarela

func _ready():
	print("=== INICIANDO PUZZLE ===")
	
	# Buscar as labels de forma mais robusta
	buscar_labels()
	
	# Conectar alavancas
	var todas_alavancas = get_tree().get_nodes_in_group("alavancas")
	for alavanca in todas_alavancas:
		if alavanca.has_signal("alavanca_ativada"):
			alavanca.alavanca_ativada.connect(_on_alavanca_ativada)
		if alavanca.has_signal("alavanca_desativada"):
			alavanca.alavanca_desativada.connect(_on_alavanca_desativada)
	
	print("Labels encontradas - Azul: ", label_azul != null, " Amarela: ", label_amarela != null)

func buscar_labels():
	# Tentar vários caminhos possíveis
	label_azul = get_node_or_null("Multiplicacao_azul")
	label_amarela = get_node_or_null("Multiplicacao_amarelo")
	
	# Se não encontrou, tentar como filhas diretas
	if not label_azul:
		for child in get_children():
			if "azul" in child.name.to_lower() and child is Label:
				label_azul = child
				break
	
	if not label_amarela:
		for child in get_children():
			if "amarelo" in child.name.to_lower() and child is Label:
				label_amarela = child
				break
	
	# Se ainda não encontrou, tentar buscar em toda a cena
	if not label_azul:
		var labels = get_tree().get_nodes_in_group("labels")
		for label in labels:
			if "azul" in label.name.to_lower():
				label_azul = label
				break
	
	if not label_amarela:
		var labels = get_tree().get_nodes_in_group("labels")
		for label in labels:
			if "amarelo" in label.name.to_lower() or "amarela" in label.name.to_lower():
				label_amarela = label
				break

func _on_alavanca_ativada(cor, numero):
	if cor == "azul":
		if not alavancas_azuis_ativas.has(numero):
			alavancas_azuis_ativas.append(numero)
	else:
		if not alavancas_amarelas_ativas.has(numero):
			alavancas_amarelas_ativas.append(numero)
	verificar_combinacao()

func _on_alavanca_desativada(cor, numero):
	if cor == "azul":
		alavancas_azuis_ativas.erase(numero)
	else:
		alavancas_amarelas_ativas.erase(numero)
	verificar_combinacao()

func verificar_combinacao():
	var multiplicacao_azul = 1
	var multiplicacao_amarela = 1
	
	for numero in alavancas_azuis_ativas:
		multiplicacao_azul *= numero
	
	for numero in alavancas_amarelas_ativas:
		multiplicacao_amarela *= numero
	
	# CORREÇÃO: INVERTER AS LABELS
	if label_azul and is_instance_valid(label_azul):
		label_azul.text = str(multiplicacao_amarela)  # ← Agora mostra amarela
	else:
		print("❌ Label Azul não disponível")
	
	if label_amarela and is_instance_valid(label_amarela):
		label_amarela.text = str(multiplicacao_azul)  # ← Agora mostra azul
	else:
		print("❌ Label Amarela não disponível") 
	var resultado_final = multiplicacao_azul + multiplicacao_amarela
	if resultado_final == numero_da_porta:
		print("🎉 PUZZLE RESOLVIDO! 🎉")
		puzzle_solved.emit(resultado_final)
