extends Node

var is_active = false

func start_dialog(lines: Array[String]):
	if is_active:
		return
	
	print("🎬 Iniciando diálogo SIMPLES")
	is_active = true
	
	# Criar uma caixa de diálogo MUITO SIMPLES
	var dialog_container = Control.new()
	dialog_container.name = "SimpleDialog"
	
	# Fundo
	var background = ColorRect.new()
	background.color = Color(0, 0, 0, 0.8)  # Preto semi-transparente
	background.size = Vector2(600, 150)
	dialog_container.add_child(background)
	
	# Texto
	var label = Label.new()
	label.text = lines[0]  # Mostra apenas a primeira linha
	label.add_theme_color_override("font_color", Color.WHITE)
	label.add_theme_font_size_override("font_size", 20)
	label.position = Vector2(20, 20)
	label.size = Vector2(560, 110)
	dialog_container.add_child(label)
	
	# Posicionar na tela
	var viewport_size = get_viewport().get_visible_rect().size
	dialog_container.position = Vector2(
		(viewport_size.x - 600) / 2,
		viewport_size.y - 200
	)
	
	get_tree().root.add_child(dialog_container)
	print("✅ Diálogo simples criado - DEVE APARECER!")
	
	# Timer para auto-remover após 3 segundos (apenas para teste)
	await get_tree().create_timer(3.0).timeout
	end_dialog()

func end_dialog():
	var dialog = get_tree().root.get_node_or_null("SimpleDialog")
	if dialog:
		dialog.queue_free()
	is_active = false
	print("🗑️ Diálogo removido")

func _input(event):
	if event.is_action_pressed("advance_message") and is_active:
		print("➡️ Avançando mensagem (simples)")
		end_dialog()
