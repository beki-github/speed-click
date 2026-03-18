extends Node2D

var circle_node = preload("res://scenes/circle.tscn")

var rng=RandomNumberGenerator.new()

var score = 0

func _ready() -> void:
	spawn_circle()

func spawn_circle():
	var new_circle = circle_node.instantiate()
	new_circle.cleared.connect(_on_circle_cleared)
	new_circle.position=Vector2i(rng.randi_range(-370,370),rng.randi_range(-270,270))
	add_child(new_circle)

func _on_circle_cleared():
	score += 1
	get_node("Camera2D/Score").text = "Score: "+ str(score)
	spawn_circle()

func _process(_delta: float) -> void:
	pass
