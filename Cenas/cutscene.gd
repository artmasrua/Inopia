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
	
	if sprite_vermelho:
		sprite_vermelho.hide()
		sprite_vermelho.texture = texture_tela_vermelha
		sprite_vermelho.position = Vector2(640, 360)
		sprite_vermelho.scale = Vector2(10, 10)
		sprite_vermelho.modulate = Color(1, 1, 1, 1)
	
	# Iniciar cutscene diretamente
	await get_tree().create_timer(1.0).timeout
	iniciar_cutscene()

func iniciar_cutscene():
	show()
	cutscene_ativa = true
	indice_atual = 0
	
	if sprite_vermelho:
		sprite_vermelho.hide()
	
	_iniciar_sequencia()

func _iniciar_sequencia():
	
	_trocar_imagem(0)
	await _esperar(5.0)
	 
	_trocar_imagem(1)
	await _esperar(5.0)
	
	for i in range(3):
		_trocar_imagem(1)
		await _mostrar_vermelho()
		await _esperar(1.0)
	
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
			

func _mostrar_vermelho():
	sprite_imagem.hide()
	
	if sprite_vermelho:
		sprite_vermelho.show()
	
	await get_tree().create_timer(0.4).timeout
	
	if sprite_vermelho:
		sprite_vermelho.hide()
	sprite_imagem.show()

func _esperar(segundos):
	await get_tree().create_timer(segundos).timeout

func _finalizar_cutscene():
	cutscene_ativa = false
	hide()
	carregar_fase1()

func carregar_fase1():
	get_tree().change_scene_to_file("res://Cenas/fase_1.tscn")
