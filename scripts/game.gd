extends Node2D

var circle_node = preload("res://scenes/circle.tscn")

func _ready() -> void:
	spawn_circle()

func spawn_circle():
	var new_circle = circle_node.instantiate()
	new_circle.cleared.connect(_on_circle_cleared)
	add_child(new_circle)

func _on_circle_cleared():
	spawn_circle()

func _process(_delta: float) -> void:
	pass
