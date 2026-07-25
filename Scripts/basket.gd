extends Area2D

@export var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir = Input.get_axis("ui_left","ui_right")
	position.x+= dir*speed*delta
	var half_width = 80
	position.x = clamp(position.x, half_width, get_viewport_rect().size.x - half_width)
