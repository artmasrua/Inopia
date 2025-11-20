extends CharacterBody2D

@export_group("Movimentação")
@export var speed = 170.0
@export var jump_velocity = -350.0

@export_group("Stomping Enemies")
@export var min_stomp_degree = 35
@export var max_stomp_degree = 145
@export var stomp_y_velocity = -150

var current_hp = 100
var can_be_hited = true
var is_dead = false
signal dano

@onready var sprite := $AnimatedSprite2D
func _ready() -> void:
	add_to_group("player")


func _physics_process(delta: float) -> void:
	# Gravidade
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Pulo
	if Input.is_action_just_pressed("pulo_rato") and is_on_floor():
		velocity.y = jump_velocity

	# Direção
	var direction := Input.get_axis("esquerda_rato", "direita_rato")

	if direction != 0:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	# Flip do sprite (aqui está o ajuste)
	if direction > 0:
		sprite.flip_h = false  # direita
	elif direction < 0:
		sprite.flip_h = true   # esquerda

	# Chama animações
	$AnimatedSprite2D.trigger_animation(velocity, direction)

	move_and_slide()


func _on_area_2d_area_entered(area):
	if not (area is Enemy) or is_dead:
		return

	var angle = rad_to_deg(position.angle_to_point((area as Enemy).position))

	if angle > min_stomp_degree and angle < max_stomp_degree:
		(area as Enemy).die()
		velocity.y = stomp_y_velocity
	else:
		emit_signal("dano")


func die():
	speed = 0
	jump_velocity = 0
	$"../CanvasLayer/Tela_Morte".visible = true

func _on_barra_de_vida_rato_die() -> void:
	die()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$"../CanvasLayer/Tela_Morte".visible = true
