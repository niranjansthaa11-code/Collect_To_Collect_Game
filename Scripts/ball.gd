extends Area2D
@export var speed_of_jharing = 300





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_event.connect(_on_input_event)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	position.y += speed_of_jharing*delta
	if position.y > get_viewport_rect().size.y + 50:
		queue_free() #missed ball remove hanna
		
	
	pass


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		get_tree().call_group("game_manager", "add_score")
		queue_free()
