extends Node2D

var circle_node = preload("res://scenes/circle.tscn")

var game_over = preload("res://scenes/GameOver.tscn")

var rng=RandomNumberGenerator.new()

var score = 0

var startTime = 20

var game_running = true

func _ready() -> void:
	spawn_circle()
	
func Game_over_box():
	var game_over_tab = game_over.instantiate()
	game_over_tab.get_node("Control/Panel/LatestScore").text = str(score)
	game_over_tab.retry_pressed.connect(_on_retry_pressed)
	add_child(game_over_tab)

func _on_retry_pressed():
	game_running = true
	score = 0
	$Camera2D/Timer.start()
	get_node("/root/Game/Camera2D/Score").text = "0"
	for child in get_children():
		if child is Area2D:
			child.queue_free()
	spawn_circle()

func spawn_circle():
	if !game_running:
		return
	var new_circle = circle_node.instantiate()
	new_circle.cleared.connect(_on_circle_cleared)
	new_circle.position=Vector2i(rng.randi_range(-370,370),rng.randi_range(-270,270))
	add_child(new_circle)

func _on_circle_cleared():
	if !game_running:
		return
	score += 1
	get_node("/root/Game/Camera2D/Score").text = str(score)
	spawn_circle()

func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	game_running = false
	Game_over_box()
