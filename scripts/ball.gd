extends CharacterBody2D
signal caught_ball
@onready var bounce: AudioStreamPlayer2D = $bounce
@onready var hit_animation: AnimationPlayer = $hit

var direction: Vector2
var speed =1750.0
var screen_size:Vector2
@onready var on_load: AnimationPlayer = $on_load

var maxNoise:float = deg_to_rad(5.0)
var randomAngle
var realBounce

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
		var collison_normal=collison.get_normal()
		var perfect_bounce=velocity.bounce(collison_normal)
		
		var bounce_direction=perfect_bounce.normalized()
		var angle_from_normal=bounce_direction.angle_to(collison_normal)

		if abs(angle_from_normal)<0.3:
			print("treshHOld!!"+str(angle_from_normal))
			var angle_nudge = deg_to_rad(10.0) if randf() > 0.5 else deg_to_rad(-10.0)
			perfect_bounce=perfect_bounce.rotated(angle_nudge)
		
		
		velocity=perfect_bounce
		

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
		
