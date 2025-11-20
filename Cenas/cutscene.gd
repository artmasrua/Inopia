extends CanvasLayer

@export var imagens_cutscene: Array[Texture2D]
@export var textos_cutscene: Array[String]
@export var texture_tela_vermelha: Texture2D

@onready var sprite_imagem = $Sprite2D
@onready var sprite_vermelho = $Sprite2D_Vermelho
@onready var label_texto = $Label

var cutscene_ativa = false
var indice_atual = 0

func _ready():
	print("=== DEBUG INICIAL ===")
	print("Quantidade de imagens:", imagens_cutscene.size())
	
	# ⚠️ GARANTIR que a tela vermelha comece ESCOMDIDA
	if sprite_vermelho:
		sprite_vermelho.hide()
		sprite_vermelho.texture = texture_tela_vermelha
		sprite_vermelho.position = Vector2(640, 360)
		sprite_vermelho.scale = Vector2(10, 10)
		sprite_vermelho.modulate = Color(1, 1, 1, 1)
		print("✅ Sprite vermelho configurado e ESCONDIDO")
	
	# Iniciar cutscene diretamente
	await get_tree().create_timer(1.0).timeout
	iniciar_cutscene()

func iniciar_cutscene():
	print("🎬 INICIANDO CUTSCENE NORMAL")
	show()
	cutscene_ativa = true
	indice_atual = 0
	
	# ⚠️ GARANTIR DUPLA que vermelho está escondido
	if sprite_vermelho:
		sprite_vermelho.hide()
	
	_iniciar_sequencia()

func _iniciar_sequencia():
	print("📋 Iniciando sequência de cenas...")
	
	# Imagem 1 - 5 segundos
	_trocar_imagem(0)
	await _esperar(5.0)
	
	# Imagem 2 - 5 segundos  
	_trocar_imagem(1)
	await _esperar(5.0)
	
	# Imagem 2 + Vermelha (3 repetições)
	for i in range(3):
		print("🔴 Cena vermelha ", i + 1, "/3")
		_trocar_imagem(1)
		await _mostrar_vermelho()
		await _esperar(2.0)
	
	# Continuar com TODAS as imagens
	_trocar_imagem(2)
	await _esperar(5.0)
	
	_trocar_imagem(3)
	await _esperar(5.0)
	
	_trocar_imagem(4)
	await _esperar(5.0)
	
	_trocar_imagem(5)
	await _esperar(5.0)
	
	_trocar_imagem(6)
	await _esperar(5.0)
	
	_finalizar_cutscene()

func _trocar_imagem(indice):
	if indice < imagens_cutscene.size():
		indice_atual = indice
		sprite_imagem.texture = imagens_cutscene[indice]
		
		if indice < textos_cutscene.size() and textos_cutscene[indice] != "":
			label_texto.text = textos_cutscene[indice]
		else:
			label_texto.text = "Cena " + str(indice + 1)
			
		print("🖼️ Imagem ", indice + 1, " de ", imagens_cutscene.size())

func _mostrar_vermelho():
	print("🔴 Mostrando tela vermelha...")
	sprite_imagem.hide()
	
	if sprite_vermelho:
		sprite_vermelho.show()
		print("   Sprite vermelho visível")
	
	await get_tree().create_timer(0.8).timeout
	
	if sprite_vermelho:
		sprite_vermelho.hide()
	sprite_imagem.show()
	print("✅ Tela vermelha removida")

func _esperar(segundos):
	print("⏰ Esperando ", segundos, "s")
	await get_tree().create_timer(segundos).timeout

func _finalizar_cutscene():
	print("🎬 CUTSCENE FINALIZADA")
	cutscene_ativa = false
	hide()
	carregar_fase1()

func carregar_fase1():
	print("🚀 Carregando Fase 1...")
	get_tree().change_scene_to_file("res://Cenas/fase_1.tscn")
