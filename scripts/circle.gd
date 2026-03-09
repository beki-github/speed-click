extends Area2D

var inCircle:=false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	inCircle=true
	print("in")


func _on_mouse_exited() -> void:
	inCircle=false
	print("out")


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		if inCircle and event.is_pressed():
			print("circle listen to your event")
			queue_free()
