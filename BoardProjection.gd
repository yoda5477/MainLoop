extends TextureRect

@export var camera:Camera2D

var mouse_start_pos
var screen_start_position
var dragging = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if event.is_action("Drag"):
		print(event)
		if event.is_pressed():
			mouse_start_pos = event.position
			screen_start_position = camera.position
			dragging = true
		else:
			dragging = false
	elif event is InputEventMouseMotion and dragging:
		camera.position = (mouse_start_pos - event.position) / camera.zoom + screen_start_position
	elif event.is_action("Zoom In"):
		camera.zoom *= 1.1
		pass
	elif event.is_action("Zoom Out"):
		camera.zoom /= 1.1
		pass
		
