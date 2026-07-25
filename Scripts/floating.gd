extends Label

func _ready():
	z_index=100
	add_theme_font_size_override("font_size", 48)
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position:y", position.y - 60, 0.8)
	tween.tween_property(self, "modulate:a", 0.0, 0.8)
	tween.chain().tween_callback(queue_free)

func setup(text: String, color: Color):
	self.text = text
	self.modulate = color
