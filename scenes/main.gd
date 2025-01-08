extends Sprite2D

var score := [0, 0] # player and AI
const MOVE_SPEED : int = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pinkatko_timer_timeout() -> void:
	#callback na "spawn nove kulicky"
	$Pinkatko.new_ball()


func _on_score_player_body_entered(body: Node2D) -> void:
	#ai skoruje
	score[1] += 1
	$SCORE/AIScore.text = str(score[1])
	$PinkatkoTimer.start()

func _on_score_ai_body_entered(body: Node2D) -> void:
	#hrac skoruje
	score[0] += 1
	$SCORE/PlayerScore.text = str(score[0])
	$PinkatkoTimer.start()
