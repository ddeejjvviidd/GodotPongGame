extends StaticBody2D

var window_height : int
var p_height : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# height of window
	window_height = get_viewport_rect().size.y
	
	#size of platform
	p_height = $ColorRect.get_size().y
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $"..".menu_opened == false:
		# movement
		if Input.is_action_pressed("ui_up"):
			position.y -= get_parent().MOVE_SPEED * delta
		elif Input.is_action_pressed("ui_down"):
			position.y += get_parent().MOVE_SPEED * delta

		# limit movement not to go behind the edge of screen
		position.y = clamp(position.y, p_height / 2, window_height - p_height /2)
