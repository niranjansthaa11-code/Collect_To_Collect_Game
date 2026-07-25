extends Area2D
@export var speed_of_jharing = 300
var is_sub_ball = false
var can_flip = false
var flip_timer = 0.0
var flip_at_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_event.connect(_on_input_event)
	is_sub_ball =randf()<0.5
	if is_sub_ball:
		modulate = Color(0,0,0)
	else:
		modulate= Color(1,1,1)
		#for the more flippy game 
		can_flip = randf()<0.25
		if can_flip:
			flip_at_time=randf_range(0.5,1)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	position.y += speed_of_jharing*delta
	if position.y > get_viewport_rect().size.y + 50:
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
		if is_sub_ball:
			get_tree().call_group("game_manager","subtract_time")
		else:
			get_tree().call_group("game_manager", "add_time")
			var tween = create_tween()
			tween.tween_property(self,"scale",scale*1.5,0.15)
			tween.parallel().tween_property(self, "modulate:a", 0.0, 0.15)
			tween.tween_callback(queue_free)
