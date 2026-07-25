extends Area2D
@export var speed_of_jharing = 300





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	position.y += speed_of_jharing*delta
	if position.y > get_viewport_rect().size.y + 50:
		queue_free() #missed ball remove hanna
		
	
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.name=="Basket":
		get_tree().call_group("game_Manager","add_score")
		queue_free()
	
	
	pass # Replace with function body.
