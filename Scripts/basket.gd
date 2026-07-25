extends Area2D

@export var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir = Input.get_axis("ui_left","ui_right")
	position.x+= dir*speed*delta
	position.x= clamp(position.x,0,get_viewport_rect().size.x)
	
