extends Node2D

signal puzzle_solved

@export var valor_correto: int = 5

# Referência para a label
var label_equacao

var alavanca_ativa = null

func _ready():
	print("=== PUZZLE 2 INICIALIZADO ===")
	
	# Buscar a label manualmente
	buscar_label()
	
	# Conectar alavancas
	for child in get_children():
		if child.is_in_group("alavancas_vermelhas"):
			print("Conectando: ", child.name, " | Valor: ", child.numero_alavanca)
			child.connect("alavanca_ativada", _on_alavanca_ativada)
			child.connect("alavanca_desativada", _on_alavanca_desativada)

func buscar_label():
	# Buscar a label
	label_equacao = null
	for child in get_children():
		if child is Label and child.name == "Label_Vermelha":
			label_equacao = child
			print("✅ Label_Vermelha encontrada")
			break
	
	if label_equacao:
		label_equacao.text = "?"  # Só mostra "?" inicialmente
		print("✅ Label inicializada")
	else:
		print("❌ Label_Vermelha não encontrada!")

func _on_alavanca_ativada(cor, numero):
	print("=== ALAVANCA ATIVADA ===")
	print("Cor: ", cor, " | Número: ", numero)
	
	# Desativar alavanca anterior
	if alavanca_ativa != null and alavanca_ativa != numero:
		for child in get_children():
			if child.is_in_group("alavancas_vermelhas") and child.numero_alavanca == alavanca_ativa:
				print("Desativando alavanca anterior: ", alavanca_ativa)
				child.desativar()
				break
	
	# Ativar nova alavanca
	alavanca_ativa = numero
	
	# ATUALIZAR LABEL - SÓ MOSTRA O NÚMERO
	if label_equacao:
		label_equacao.text = str(numero)  # Só o número
		print("✅ Label atualizada para: ", label_equacao.text)
	else:
		print("❌ Label é null - não pode atualizar")
	
	verificar_solucao()

func _on_alavanca_desativada(cor, numero):
	print("Alavanca desativada: ", numero)
	
	if alavanca_ativa == numero:
		alavanca_ativa = null
		if label_equacao:
			label_equacao.text = "?"  # Volta para "?" quando desativa
			print("✅ Label resetada para '?'")

func verificar_solucao():
	print("Verificando... Valor ativo: ", alavanca_ativa)
	
	if alavanca_ativa == valor_correto:
		print("🎉 PUZZLE 2 RESOLVIDO!")
		
		if label_equacao:
			label_equacao.text = str(alavanca_ativa) + " ✅"  # Número com check
		
		puzzle_solved.emit()

# Função para atualização manual (backup)
func atualizar_label_manual(numero):
	print("📝 Atualização MANUAL da label")
	if label_equacao:
		label_equacao.text = str(numero)  # Só o número
