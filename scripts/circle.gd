extends Area2D
signal cleared

var is_hit:=false

func _on_area_entered(area: Area2D) -> void:
	if is_hit:
		return
	if area.is_in_group("tail_group"):
		is_hit=true
		cleared.emit()
		queue_free()
