extends StaticBody2D

var pinkatko_position : Vector2
var vertical_distance : int
var move_by : int

var window_height : int
var p_height : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window_height = get_viewport_rect().size.y
	p_height = $ColorRect.get_size().y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#pohyb AI k pinkatku
	pinkatko_position = $"../Pinkatko".position
	vertical_distance = position.y - pinkatko_position.y
	
	if abs(vertical_distance) > get_parent().MOVE_SPEED * delta:
		move_by = get_parent().MOVE_SPEED * delta * (vertical_distance / abs(vertical_distance))
	else:
		move_by = vertical_distance
	
	position.y -= move_by
	
	#aby neslo nad okraje okna
	position.y = clamp(position.y, p_height / 2, window_height - p_height / 2)
