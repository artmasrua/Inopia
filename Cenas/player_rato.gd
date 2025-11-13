extends CharacterBody2D

@export_group("Movimentação")
@export var speed = 200.0
@export var jump_velocity = -400.0

@export_group("Stomping Enemies")
@export var min_stomp_degree = 35
@export var max_stomp_degree = 145
@export var stomp_y_velocity = -150

var is_dead = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("pulo_rato") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("esquerda_rato", "direita_rato")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	


func _on_area_2d_area_entered(area):
	if not (area is Enemy) or is_dead:
		return
	
	var angle = rad_to_deg(position.angle_to_point((area as Enemy).position))
	
	if angle > min_stomp_degree and angle < max_stomp_degree:
		(area as Enemy).die()
		velocity.y = stomp_y_velocity
	else:
		pass #vai tomar dano aqui
