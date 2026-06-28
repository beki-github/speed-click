extends Node
signal speed_increase(amount: float)
@onready var timer:Timer=$Timer

var wait_time: float =5.0
var increase_amount:=300.0

var current_speed: float =1750.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	timer.wait_time=wait_time
	timer.one_shot=false
	timer.autostart=true
	timer.ignore_time_scale=true
	timer.timeout.connect(_on_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_timeout()->void:
	current_speed+=increase_amount
	speed_increase.emit(current_speed)
