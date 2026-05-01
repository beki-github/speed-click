extends Panel

signal retry_pressed

func _on_retry_pressed() -> void:
	retry_pressed.emit()
	queue_free()
	


func _on_exit_pressed() -> void:
	get_tree().quit()
