extends Sprite2D

var window_size : Vector2
var score := [0, 0] # player [0] and AI [1] score
const MOVE_SPEED : int = 500 # move speed of player and AI
const AI_DIFFICULTY := [0.10, 0.40, 0.70, 1.0]
var current_difficulty : float # selected difficulty
var playing : bool = false # if we're playing
var menu_opened : bool = true
var sound_player : AudioStreamPlayer
var scored = load("res://assets/crash.mp3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window_size = get_viewport_rect().size
	current_difficulty = AI_DIFFICULTY[1]
	
	sound_player = AudioStreamPlayer.new()
	add_child(sound_player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event.is_action_released("ui_cancel") and not menu_opened:
		$GameMenu/Panel.visible = true
		menu_opened = true

func start_game() -> void:
	$Pinkatko.new_ball()
	
func pause_game() -> void:
	$PinkatkoTimer.paused
	$Pinkatko.speed = 0
	
func _on_pinkatko_timer_timeout() -> void:
	# callback for restarting the game and spawning a new ball
	start_game()


func _on_score_player_body_entered(body: Node2D) -> void:
	# AI has points
	sound_player.stream = scored
	sound_player.play()
	
	score[1] += 1
	$SCORE/AIScore.text = str(score[1])
	$PinkatkoTimer.start()

func _on_score_ai_body_entered(body: Node2D) -> void:
	# Player has points
	sound_player.stream = scored
	sound_player.play()
	
	score[0] += 1
	$SCORE/PlayerScore.text = str(score[0])
	$PinkatkoTimer.start()


func _on_option_button_item_selected(index: int) -> void:
	# changes current difficulty based on selection in menu
	current_difficulty = AI_DIFFICULTY[index]
		


func _on_start_resume_pressed() -> void:
	if(playing == false):
		# new game starting
		playing = true
		start_game()
		$GameMenu/Panel/Start_resume.text = "Resume"
		$GameMenu/Panel/Reset.disabled = false
		$GameMenu/Panel/OptionButton.disabled = true
		
	menu_opened = false
	$GameMenu/Panel.visible = false
		


func _on_reset_pressed() -> void:
	$GameMenu/Panel/Reset.disabled = true
	$GameMenu/Panel/OptionButton.disabled = false
	$GameMenu/Panel/Start_resume.text = "Start"
	playing = false
	score[0] = 0
	score[1] = 0
	$SCORE/PlayerScore.text = "0"
	$SCORE/AIScore.text = "0"
	$Player.position.y = window_size.y / 2
	$AI.position.y = window_size.y / 2
	$Pinkatko.position.x = window_size.x / 2
