extends Node2D

@onready var area2d = $area_sign
@onready var texto = $texture

const lines : Array[String] = [
	"Ola, ",
	"Oi, vou te ajudar durante a sua jornada",
	"Aaaaaaaaaa",
	"aaaaaaaaa",
]

func _unhandled_input(event: InputEvent) -> void:
	if area2d.get_overlapping_bodies().size() > 0:
		texto.show()
		if event.is_action_pressed("interagir") && !DialogManager.is_message_active:
			texto.hide()
			DialogManager.start_message(global_position, lines)
	else:
		texto.hide()
		if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()
			DialogManager.is_message_active = false
			
