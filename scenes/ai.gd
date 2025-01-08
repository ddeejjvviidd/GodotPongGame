extends StaticBody2D

var pinkatko_position : Vector2 # location of the ball
var pinkatko_speed : int
var vertical_distance : int # vertical distance of AI platform from the ball
var move_by : int # by how much does platform need to move

var window_height : int 
var p_height : int  # height of the ball

var difficulty : float # AI difficulty

var bounce_offset : int
const MAX_BOUNCE_OFFSET : int = 40 # height of the platform is 120 / 2 = 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window_height = get_viewport_rect().size.y
	p_height = $ColorRect.get_size().y
	bounce_offset = [1, -1].pick_random()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $"..".menu_opened == false:
		# AI moves to counter
		difficulty = get_parent().current_difficulty
		print(difficulty)
		pinkatko_speed = $"../Pinkatko".speed
		pinkatko_position = $"../Pinkatko".position
		
		# distance of a center of platform to the pinkatko
		var adjusted_pinkatko_position = pinkatko_position.y + ( (MAX_BOUNCE_OFFSET * difficulty) * bounce_offset)
		vertical_distance = (position.y - adjusted_pinkatko_position)
		
		var adjusted_speed = get_parent().MOVE_SPEED - 200 + (200 * difficulty)
		
		# checking if the ball is closer to the edge of AI platform
		if abs(vertical_distance) > adjusted_speed * delta:
			move_by = adjusted_speed * delta * (vertical_distance / abs(vertical_distance))
		else:
			move_by = vertical_distance
		
		position.y -= move_by
		
		# limit movement not to go behind the edge of screen
		position.y = clamp(position.y, p_height / 2, window_height - p_height / 2)
