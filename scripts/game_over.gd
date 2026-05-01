extends Node2D

signal retry_pressed

func _on_retry_btn_pressed() -> void:
	retry_pressed.emit()
	queue_free()

func _on_exit_btn_pressed() -> void:
	get_tree().quit()
