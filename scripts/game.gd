extends Node2D

var circle_node = preload("res://scenes/circle.tscn")
var ball_node=preload("res://scenes/ball.tscn")
var game_over = preload("res://scenes/GameOver.tscn")
var tail_node=preload("res://scenes/tail.tscn")
var start_menu=preload("res://scenes/start_menu.tscn")
var Game_Over=preload("res://scenes/Game_Over.tscn")
var rng=RandomNumberGenerator.new()
var score = 0
var startTime = 20
var game_running:=false

var tail_array=[]
var tail_num:=10
var tail_size

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
	tail_size=0.15
	if tail_array.is_empty():
		for tail in tail_num:
			var tail_=tail_node.instantiate()
			tail_.position=Vector2(0,0)
			tail_.scale=Vector2(tail_size,tail_size)
			tail_size*=0.90
			add_child(tail_)
			tail_array.append(tail_)
			


func Game_over_box():
	#var game_over_tab = game_over.instantiate()
	#game_over_tab.get_node("Control/Panel/scoresLabel").text += str(score)
	#game_over_tab.retry_pressed.connect(_on_retry_pressed)
	#add_child(game_over_tab)
	var game_over=Game_Over.instantiate()
	game_over.retry_pressed.connect(_on_retry_pressed)
	game_over.get_node("highScore").text+=str(340)
	game_over.get_node("currentScore").text+=str(score)
	add_child(game_over)

func _ready() -> void:
	#var start_menu_child=start_menu.instantiate()
	#start_menu_child.start_clicked.connect(on_start_clicked)
	#add_child(start_menu_child)
	Game_over_box()
	

func _physics_process(delta: float) -> void:
	if game_running:
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

func on_start_clicked():
	start_Game()
	

func on_ball_cleared():
	score=score-5
	freeze_time(0.75)
	spawn_ball()

func _on_circle_cleared():
	if !game_running:
		return
	score += 10
	get_node("/root/Game/Camera2D/Score").text = "Score: "+str(score)
	spawn_circle()
	

func _on_retry_pressed():
	start_Game()
	

func _on_timer_timeout() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Game_over_box()
	game_running = false
	

func freeze_time(duration: float = 1.0):
	Engine.time_scale = 0.0
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = 1.0
