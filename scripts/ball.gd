extends CharacterBody2D
signal caught_ball

var direction: Vector2
var speed: int =2000
var screen_size:Vector2


var is_hit=false
var score=10

func _ready():
	direction=get_random_direction()
	velocity=direction*speed
	
func _physics_process(delta: float) -> void:
	var collison=move_and_collide(velocity*delta)
	if collison:
		velocity=velocity.bounce(collison.get_normal())

func get_random_direction() -> Vector2:
	var new_direction: Vector2
	var random_angle=randf_range(0,TAU)
	return Vector2.RIGHT.rotated(random_angle).normalized()



func _on_area_2d_area_entered(area: Area2D) -> void:
	if is_hit:
		return
	if area.is_in_group("tail_group"):
		is_hit=true
		caught_ball.emit()
		queue_free()
