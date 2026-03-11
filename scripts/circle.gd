extends Area2D
signal  cleared

var x:=4




func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("circle listen to your event")
		x+=1
		print(x)
		cleared.emit()
		queue_free()
