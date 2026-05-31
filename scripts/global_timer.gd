extends Node
signal speed_increase(amount: float)
@onready var timer:Timer=$Timer

var wait_time: float =10.0
var increase_amount:=300.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time=wait_time
	timer.one_shot=false
	timer.autostart=true
	timer.timeout.connect(_on_timeout)
	timer.start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_timeout()->void:
	speed_increase.emit(increase_amount)
