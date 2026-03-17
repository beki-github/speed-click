extends Area2D
signal cleared

@onready var shape = $CollisionShape2D

func _process(_delta):
		var r = shape.shape.radius
		if get_local_mouse_position().length() <= r:
			cleared.emit()
			queue_free()
