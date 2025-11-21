extends AnimatedSprite2D

signal alavanca_ativada(cor, numero)
signal alavanca_desativada(cor, numero)

@export var cor_alavanca: String = "branca"
@export var numero_alavanca: int = 20 

var esta_ativa: bool = false
var player_proximo: bool = false

func _ready():
	add_to_group("alavancas_brancas")
	
	$Area2D.body_entered.connect(_on_area2d_body_entered)
	$Area2D.body_exited.connect(_on_area2d_body_exited)
	
	play("desativada")

func _on_area2d_body_entered(body):
	$BrancaEx_2.show()
	if body.is_in_group("player"):
		player_proximo = true

func _on_area2d_body_exited(body):
	$BrancaEx_2.hide()
	if body.is_in_group("player"):
		player_proximo = false

func _process(delta):
	if player_proximo and Input.is_action_just_pressed("interagir"):
		alternar_alavanca()

func alternar_alavanca():
	esta_ativa = !esta_ativa
	
	if esta_ativa:
		play("ativada")
		alavanca_ativada.emit(cor_alavanca, numero_alavanca)
	else:
		play("desativada")
		alavanca_desativada.emit(cor_alavanca, numero_alavanca)

func desativar():
	if esta_ativa:
		esta_ativa = false
		play("desativada")
		alavanca_desativada.emit(cor_alavanca, numero_alavanca)

func resetar():
	esta_ativa = false
	play("desativada")
