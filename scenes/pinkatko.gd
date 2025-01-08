extends CharacterBody2D

var window_size : Vector2
const SPEED : int = 500
const ACCELERATION : int = 50
var speed: int
var direction : Vector2
const MAX_Y_VECTOR : float = 0.6

func _ready() -> void:
	window_size = get_viewport_rect().size

func new_ball():
	position.x = window_size.x / 2
	position.y = randi_range(200, window_size.y - 200)
	
	speed = SPEED
	direction = random_direction()


func random_direction():
	var new_dir := Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(-1, 1)
	return new_dir.normalized()


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction * speed * delta)
	var collider
	
	if collision:
		collider = collision.get_collider()
		
		#pokud pinkatko zasahlo kraje vlevo vpravo
		if collider == $"../Player" or collider == $"../AI":
			speed += ACCELERATION
			direction = new_direction(collider)
			
		else:
			direction = direction.bounce(collision.get_normal())


func new_direction(collider):
	var pinkatko_y = position.y
	var pad_y = collider.position.y
	var dist = pinkatko_y - pad_y #dist vzdalenost od stredu
	var new_dir := Vector2()
	
	#prevratit horizontalni direkci x
	if direction.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
	
	# nutno zvazit kde se pinkatko odrazilo a dle toho upravit uhel odrazeni
	
	new_dir.y = (dist / (collider.p_height / 2)) * MAX_Y_VECTOR
	
	return new_dir.normalized()
