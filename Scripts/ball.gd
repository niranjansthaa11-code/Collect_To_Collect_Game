extends Area2D
@export var speed_of_jharing = 600
var is_sub_ball = false
var can_flip = false
var flip_timer = 0.0
var flip_at_time = 0.0

var floating_text = preload("res://Scences/Floating.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_event.connect(_on_input_event)
	is_sub_ball =randf()<0.5
	if is_sub_ball:
		modulate = Color(0,0,0)
	else:
		modulate= Color(1,1,1)
		#for the more flippy game 
		can_flip = randf()<0.45
		if can_flip:
			flip_at_time=randf_range(0.9,1.5)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	position.y += speed_of_jharing*delta
	if position.y > get_viewport_rect().size.y + 50:
		if not is_sub_ball:
			spwanned_missed()
			get_tree().call_group("game_manager", "missed_good_ball")
		queue_free() #missed ball remove hanna
		
	
	pass
	if can_flip:
		flip_timer += delta
		if flip_timer >= flip_at_time:
			is_sub_ball=true
			modulate = Color(0,0,0)
			can_flip = false

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		spwan_floating_text()
		if is_sub_ball:
			get_tree().call_group("game_manager","subtract_time")
			$Lost.play()
		else:
			$Gain.play()
			get_tree().call_group("game_manager", "add_time")
			var tween = create_tween()
			tween.tween_property(self,"scale",scale*1.5,0.15)
			tween.parallel().tween_property(self, "modulate:a", 0.0, 0.15)
			tween.tween_callback(queue_free)
func spwan_floating_text():
	var ft = floating_text.instantiate()
	get_parent().add_child(ft)
	ft.global_position = global_position
	if is_sub_ball:
		ft.setup("-3s", Color(1, 0, 0)) 
	else:
		ft.setup("+2s", Color(0.705, 0.1, 0.17, 1.0))  
func spwanned_missed():
	var ft = floating_text.instantiate()
	get_parent().add_child(ft)
	ft.global_position = global_position
	ft.setup("-1s", Color(0.593, 0.013, 0.0, 1.0))
