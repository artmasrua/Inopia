extends AnimatedSprite2D

signal alavanca_ativada(cor, numero)
signal alavanca_desativada(cor, numero)

@export var cor_alavanca: String = "azul"
@export var numero_alavanca: int = 7

var esta_ativa: bool = false
var player_proximo: bool = false

func _ready():
	add_to_group("alavancas")
	print("Alavanca pronta: ", name, " - Cor: ", cor_alavanca, " Numero: ", numero_alavanca)
	
	# Verificar se tem Area2D
	if has_node("Area2D"):
		$Area2D.body_entered.connect(_on_area2d_body_entered)
		$Area2D.body_exited.connect(_on_area2d_body_exited)
	else:
		print("ERRO: Area2D não encontrada em ", name)
	
	play("desativada")

func _on_area2d_body_entered(body):
	$AzulEx_7.show()
	if body.is_in_group("player"):
		player_proximo = true

func _on_area2d_body_exited(body):
	$AzulEx_7.hide()
	if body.is_in_group("player"):
		player_proximo = false

func _process(delta):
	# Verificar input no _process em vez de _input para melhor detecção
	if player_proximo and Input.is_action_just_pressed("interagir"):
		alternar_alavanca()

func alternar_alavanca():
	esta_ativa = !esta_ativa
	print("Alternando alavanca ", name, " para: ", esta_ativa)
	
	if esta_ativa:
		play("ativada")
		alavanca_ativada.emit(cor_alavanca, numero_alavanca)
	else:
		play("desativada")
		alavanca_desativada.emit(cor_alavanca, numero_alavanca)
