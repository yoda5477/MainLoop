extends GridContainer

@export var cardPanel: Panel
var mainMenu:GridContainer
var currentDragged: String = ""
var cardPath: String = "res://Cards/"
var is_dragging: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	mainMenu=get_node("MainCardMenu")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_menu_button_down(extra_arg_0):
	is_dragging = true
	currentDragged = cardPath+extra_arg_0
	print("DEBUG : start dragging %s" % [currentDragged])
	mainMenu.close_submenu()
	var newCardPath = load(currentDragged)
	var newCard:Area2D = newCardPath.instantiate()
	newCard.global_position = get_global_mouse_position() + (newCard.transform.origin)
	cardPanel.add_child(newCard)
	
