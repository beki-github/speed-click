extends Area2D
signal cleared


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("tail_group"):
		cleared.emit()
		queue_free()
