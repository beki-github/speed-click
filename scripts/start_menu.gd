extends Panel

@onready var vBox =$VBoxContainer
signal start_clicked
func _ready() -> void:
	for button in vBox.get_children():
		button.pressed.connect(_on_button_presses.bind(button.name))
	

func _on_button_presses(button_name:String):
	match button_name:
		"start":
			start_clicked.emit()
			queue_free()
		"exit":
			get_tree().quit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
