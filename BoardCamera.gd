extends Camera2D

var mouse_start_pos
var screen_start_position

var dragging = false

func _ready():
	make_current()

func _input(event):
	if event.is_action("Drag"):
		print(event)
		if event.is_pressed():
			mouse_start_pos = event.position
			screen_start_position = position
			dragging = true
		else:
			dragging = false
	elif event is InputEventMouseMotion and dragging:
		position = (mouse_start_pos - event.position) / zoom + screen_start_position
	elif event.is_action("Zoom In"):
		zoom *= 1.1
		pass
	elif event.is_action("Zoom Out"):
		zoom /= 1.1
		pass
		
