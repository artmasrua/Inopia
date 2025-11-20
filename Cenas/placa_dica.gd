func _input(event):
	if player_near and event.is_action_pressed("interagir"):
		print("🔘 Botão interagir DETECTADO na placa")
		
		# TESTE DIRETO - criar diálogo na mão
		var test_dialog = Control.new()
		test_dialog.name = "TestDialogPlaca"
		
		var bg = ColorRect.new()
		bg.color = Color(1, 0, 1)  # MAGENTA - bem visível
		bg.size = Vector2(500, 120)
		test_dialog.add_child(bg)
		
		var label = Label.new()
		label.text = "DIÁLOGO DA PLACA - FUNCIONOU!"
		label.add_theme_color_override("font_color", Color.WHITE)
		label.add_theme_font_size_override("font_size", 24)
		label.position = Vector2(20, 20)
		test_dialog.add_child(label)
		
		# Posicionar
		var viewport_size = get_viewport().get_visible_rect().size
		test_dialog.position = Vector2(
			(viewport_size.x - 500) / 2,
			viewport_size.y - 150
		)
		
		get_tree().root.add_child(test_dialog)
		print("🟣 Diálogo magenta criado pela PLACA")
		
		# Auto-remover após 2 segundos
		await get_tree().create_timer(2.0).timeout
		test_dialog.queue_free()
