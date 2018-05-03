extends Label

var color
var millis = 0

func _ready():
	color = Color(1,1,1,1)
	pass

func _process(delta):
	millis += delta
	color.a = sin(millis)
	add_color_override("font_color", color)