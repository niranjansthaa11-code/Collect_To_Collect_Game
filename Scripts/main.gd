extends Node2D

var ball_scence = preload("res://Scences/Ball.tscn")
var score =0
var timeleft =30

# Called when the node enters the scene tree for the first time.
func _ready(): #if the start is pressed down 
	$Game.hide()
	$"Start Screen/PlayButton".pressed.connect(_on_play_pressed)
	$Game/Spawanner.timeout.connect(_on_spawanner_timeout)
	$Game/Countdown_TImer.timeout.connect(_on_countdown_t_imer_timeout)
	$"GameOver/Restart Button".pressed.connect(_on_restart_button_pressed)
func _on_play_pressed():
	$"Start Screen".hide()
	$Game.show()
	$Game/Spawanner.start()
	$Game/Countdown_TImer.start()
	score = 0
	timeleft = 30
	update_labels()
	print("Game is Starting...")


func _on_spawanner_timeout() -> void:
	var ball = ball_scence.instantiate()
	ball.position = Vector2(randf_range(50,670),0)
	$Game.add_child(ball)
	pass # Replace with function body.


func _on_countdown_t_imer_timeout() -> void:
	timeleft -=1
	update_labels()
	if timeleft <= 0:
		end_game()
	pass # Replace with function body.
func add_score():
	score += 1
	update_labels()
func update_labels():
	$Game/Score.text = "Score: " + str(score)
	$Game/Timer.text = "Time: " + str(timeleft)
func end_game():
	$Game/Spawanner.stop()
	$Game/CountdownTimer.stop()
	$Game.hide()
	$GameOver.show()
	$GameOver/Final_score_label.text = "Game Over!\nScore: " + str(score)

	print("Game Over! Final Score: ", score)


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.
