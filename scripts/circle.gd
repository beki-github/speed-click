extends Area2D
signal cleared


func _on_area_entered(area: Area2D) -> void:
	if area.name=="tail":
		cleared.emit()
		queue_free()
