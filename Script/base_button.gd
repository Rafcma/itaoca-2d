extends Button

signal click_end()


func _on_mouse_entered() -> void:
	$som_hover.play()

func _on_pressed() -> void:
	$som_click.play()

func _on_som_click_finished() -> void:
	emit_signal("click_end")
