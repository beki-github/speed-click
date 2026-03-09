extends Node2D

var circle_node=preload("res://scenes/circle.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var new_circle=circle_node.instantiate()
	add_child(new_circle)


	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
