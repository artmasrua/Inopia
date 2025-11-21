extends Node2D

signal puzzle_solved

@export var valor_correto: int = 5

var label_equacao

var alavanca_ativa = null

func _ready():
	
	buscar_label()
	
	for child in get_children():
		if child.is_in_group("alavancas_vermelhas"):
			print("Conectando: ", child.name, " | Valor: ", child.numero_alavanca)
			child.connect("alavanca_ativada", _on_alavanca_ativada)
			child.connect("alavanca_desativada", _on_alavanca_desativada)

func buscar_label():
	label_equacao = null
	for child in get_children():
		if child is Label and child.name == "Label_Vermelha":
			label_equacao = child
			print("✅ Label_Vermelha encontrada")
			break
	
	if label_equacao:
		label_equacao.text = "?"  
	else:
		print("❌ Label_Vermelha não encontrada!")

func _on_alavanca_ativada(cor, numero):
	
	if alavanca_ativa != null and alavanca_ativa != numero:
		for child in get_children():
			if child.is_in_group("alavancas_vermelhas") and child.numero_alavanca == alavanca_ativa:
				print("Desativando alavanca anterior: ", alavanca_ativa)
				child.desativar()
				break
	
	alavanca_ativa = numero
	
	if label_equacao:
		label_equacao.text = str(numero)
	else:
		print("❌ Label é null - não pode atualizar")
	
	verificar_solucao()

func _on_alavanca_desativada(cor, numero):
	print("Alavanca desativada: ", numero)
	
	if alavanca_ativa == numero:
		alavanca_ativa = null
		if label_equacao:
			label_equacao.text = "?"  

func verificar_solucao():
	
	if alavanca_ativa == valor_correto:
		
		if label_equacao:
			label_equacao.text = str(alavanca_ativa) + " ✅"  
		
		puzzle_solved.emit()


func atualizar_label_manual(numero):
	if label_equacao:
		label_equacao.text = str(numero)  
