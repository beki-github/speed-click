extends Line2D
var heightParent: float
var widthParent: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get the height and width of the parent node(ColorRect) 
	heightParent =get_parent().size.y/2
	widthParent =get_parent().size.x/2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var currentPosition:Vector2=get_parent().global_position
	#center the start of the line array relative to the parent node
	currentPosition.x+=heightParent
	currentPosition.y+=heightParent
	add_point(currentPosition)
	if points.size()>25:
		remove_point(0)
	pass
