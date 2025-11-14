extends Node2D

@onready var area2d = $area_sign
@onready var texto = $texture

const lines : Array[String] = [
	"Se você é um verdadeiro Gruntaniano,",
	"voce sabe que a senha da porta é uma multiplicação entre ",
	"as alavancas de mesma cor e a soma ",
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
			
