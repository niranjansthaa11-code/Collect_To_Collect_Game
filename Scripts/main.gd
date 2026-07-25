extends Node2D

var ball_scence = preload("res://Scences/Ball.tscn")
var score =0
var timeleft =10
var current_ball_speed = 500

# Called when the node enters the scene tree for the first time.
func _ready(): #if the start is pressed down 
	$Game.hide()
	$"Start Screen/PlayButton".pressed.connect(_on_play_pressed)
	$Game/Spawanner.timeout.connect(_on_spawanner_timeout)
	$Game/Countdown_TImer.timeout.connect(_on_countdown_t_imer_timeout)
	$"GameOver/Restart Button".pressed.connect(_on_restart_button_pressed)
func _on_play_pressed():
	$Woosh_sound.play()
	$"Start Screen".hide()
	$Game.show()
	$Game/Spawanner.start()
	$Game/Countdown_TImer.start()
	score = 0
	timeleft = 10
	update_labels()
	print("Game is Starting...")


func _on_spawanner_timeout() -> void:
	var ball = ball_scence.instantiate()
	ball.position = Vector2(randf_range(50,670),0)
	ball.speed_of_jharing = current_ball_speed 
	$Game.add_child(ball)
	pass # Replace with function body.


func _on_countdown_t_imer_timeout() -> void:
	timeleft -=1
	update_labels()
	$Game/Spawanner.wait_time = max(0.4, $Game/Spawanner.wait_time - 0.02)
	current_ball_speed = min(600, current_ball_speed + 8)
	if timeleft <= 3 and timeleft > 0:
		$countdown.play()
	
	if timeleft <= 5:
		$Game/Timer.modulate = Color(1, 0, 0)
	else:
		$Game/Timer.modulate = Color(1, 1, 1)
	if timeleft <= 0:
		end_game()
	pass # Replace with function body.
func add_time():
	timeleft +=2
	score+=1
	update_labels()
func subtract_time():
	timeleft -=3
	shake_screen()
	update_labels()
	if timeleft <= 0:
		end_game()
	
func  missed_good_ball():
	$Lost.play()
	timeleft -= 1  #penatly
	update_labels()
	if timeleft <= 0:
		end_game()
func update_labels():
	$Game/Score.text = "Score: " + str(score)
	$Game/Timer.text = "Time: " + str(timeleft)
	if timeleft <= 5:
		$Game/Timer.modulate = Color(1, 0, 0)  
	else:
		$Game/Timer.modulate = Color(1, 1, 1)  
	
	
func end_game():
	$countdown.stop()
	$Music_Player.stop()
	$Game/Spawanner.stop()
	$Game/Countdown_TImer.stop()
	$Game.hide()
	$GameOver.show()
	$FinalGame.play();
	$GameOver/Final_score_label.text = "Score: " + str(score)

	print(" Final Score: ", score)


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.
func shake_screen():
	var tween = create_tween()
	var original_pos = $Game.position
	for i in 5:
		tween.tween_property($Game, "position", original_pos + Vector2(randf_range(-8,8), randf_range(-8,8)), 0.03)
	tween.tween_property($Game, "position", original_pos, 0.03)
