extends Area2D
signal  cleared

func _on_mouse_entered() -> void:
	cleared.emit()
	queue_free()
