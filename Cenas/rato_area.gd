extends Area2D

@export var dialo_texts : Array[String] = []
@export var offset_position : Vector2 = Vector2(0, -70)

var player_proximo = false

func _unhandled_input(event: InputEvent) -> void:
	if  event.is_action_pressed("interagir") && player_proximo:
		DialogManager.start_dialog(dialo_texts, global_position + offset_position)

func _on_body_entered(_body: Node2D) -> void:
	$"../Sprite2D".show()
	player_proximo = true


func _on_body_exited(_body: Node2D) -> void:
	$"../Sprite2D".hide()
	player_proximo = false
