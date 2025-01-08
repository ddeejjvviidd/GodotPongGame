extends CharacterBody2D

var window_size : Vector2
const SPEED : int = 500 # starting speed of the ball
const ACCELERATION : int = 50 # acceleration during game
var speed: int # current speed of the ball
var direction : Vector2 # ball direction
const MAX_Y_VECTOR : float = 0.75 # maximum platform bounce vector

var bounce = load("res://assets/bounce.mp3")


func _ready() -> void:
	window_size = get_viewport_rect().size


func new_ball():
	# randomized position for new ball
	position.x = window_size.x / 2
	position.y = randi_range(200, window_size.y - 200)
	
	#starting speed and random direction
	speed = SPEED
	direction = random_direction()


func random_direction():
	var new_dir := Vector2() # vector for ball starting direction
	new_dir.x = [1, -1].pick_random() # ball can either go left (to player) or right (to AI)
	new_dir.y = randf_range(-1, 1) # random value for y tilt
	
	return new_dir.normalized()


func _physics_process(delta: float) -> void:
	if get_parent().menu_opened == false:
		var collision = move_and_collide(direction * speed * delta)
		var collider
		
		if collision:
			collider = collision.get_collider()
			
			if collider == $"../Player" or collider == $"../AI":
				get_parent().sound_player.stream = bounce
				get_parent().sound_player.play()
				
				# collission was with players or AI platform
				speed += ACCELERATION
				direction = new_direction(collider)
				# randomize the offset of AI bounce
				$"../AI".bounce_offset = [1, -1].pick_random()
				
			else:
				# the collission was with top or bottom borders
				direction = direction.bounce(collision.get_normal())


func new_direction(collider):
	var pinkatko_y = position.y
	var pad_y = collider.position.y
	
	# count the distance from the center of a platform
	# dist > 0 : ball was above the middle of the platform
	# dist < 0 : ball was bellow
	var dist = pinkatko_y - pad_y
	var new_dir := Vector2() 
	
	# switch x direction
	if direction.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
	
	# count the bounce direction based on where did the ball hit the platform
	# collider.p_height / 2 : normalize half of the platform, returns values from -1 to 1
	new_dir.y = (dist / (collider.p_height / 2)) * MAX_Y_VECTOR
	
	return new_dir.normalized()
