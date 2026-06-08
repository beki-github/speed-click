extends CharacterBody2D
signal caught_ball
@onready var bounce: AudioStreamPlayer2D = $bounce
@onready var hit_animation: AnimationPlayer = $hit


var direction: Vector2
var speed =1750.0
var screen_size:Vector2
@onready var on_load: AnimationPlayer = $on_load


var is_hit=false
var score=10

func _on_speed_increase(current_speed: float)->void:
	speed=current_speed
	
	

func _ready():
	on_load.play("on_load")
	GlobalTimer.speed_increase.connect(_on_speed_increase)
	direction=get_random_direction()
	velocity=direction*speed
	
func _physics_process(delta: float) -> void:
	var collison=move_and_collide(velocity*delta)
	if collison:
		bounce.play()
		velocity=velocity.bounce(collison.get_normal())

func get_random_direction() -> Vector2:
	var random_angle=randf_range(0,TAU)
	return Vector2.RIGHT.rotated(random_angle).normalized()



func _on_area_2d_area_entered(area: Area2D) -> void:
	if is_hit:
		return
	if area.is_in_group("tail_group"):
		is_hit=true
		caught_ball.emit()
		hit_animation.play("hit_animation")
		
