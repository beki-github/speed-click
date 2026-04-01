extends Node2D

var circle_node = preload("res://scenes/circle.tscn")
var ball_node=preload("res://scenes/ball.tscn")
var game_over = preload("res://scenes/GameOver.tscn")
var tail_node=preload("res://scenes/tail.tscn")
var rng=RandomNumberGenerator.new()
var score = 0
var startTime = 20
var game_running:=true

var tail_array=[]
var tail_num:=10

func spawn_circle():
	if !game_running:
		return
	var new_circle = circle_node.instantiate()
	new_circle.cleared.connect(_on_circle_cleared)
	new_circle.position=Vector2(rng.randi_range(-370,370),rng.randi_range(-270,270))
	new_circle.scale=Vector2(0.25,0.25)
	add_child(new_circle)
	

func spawn_ball():
	if !game_running:
		return
	var new_ball=ball_node.instantiate()
	new_ball.position=Vector2(rng.randi_range(-370,370),rng.randi_range(-270,270))
	new_ball.caught_ball.connect(on_ball_cleared)
	add_child(new_ball)


func start_Game() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	game_running = true
	score = 0
	$Timer.start()
	get_node("/root/Game/Camera2D/Score").text = "0"
	for child in get_children():
		if (child is Area2D or child is CharacterBody2D) and !child.is_in_group("tail_group"):
			child.queue_free()
	spawn_circle()
	spawn_ball()
	if tail_array.is_empty():
		for tail in tail_num:
			var tail_=tail_node.instantiate()
			tail_.position=Vector2(0,0)
			tail_.scale=Vector2(0.15,0.15)
			add_child(tail_)
			tail_array.append(tail_)
			


func Game_over_box():
	var game_over_tab = game_over.instantiate()
	game_over_tab.get_node("Control/Panel/LatestScore").text = str(score)
	game_over_tab.retry_pressed.connect(_on_retry_pressed)
	add_child(game_over_tab)


func _ready() -> void:
	start_Game()

func _physics_process(delta: float) -> void:
	get_node("/root/Game/Camera2D/Timer").text = "Timer: "+str(int($Timer.time_left))
	var mouse_pos=get_global_mouse_position()
	if !tail_array.is_empty():
		for index in range(0,tail_array.size()):
			if index==0:
				tail_array[index].global_position=tail_array[index].global_position.lerp(mouse_pos,1)
			else:
				tail_array[index].global_position=tail_array[index].global_position.lerp(tail_array[index-1].global_position,0.5)
	else:
		print("the tail is fucked up")

func on_ball_cleared():
	spawn_ball()

func _on_circle_cleared():
	if !game_running:
		return
	score += 1
	get_node("/root/Game/Camera2D/Score").text = "Score: "+str(score)
	spawn_circle()
	

func _on_retry_pressed():
	start_Game()

func _on_timer_timeout() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	game_running = false
	Game_over_box()
