extends GridContainer

var currentSubMenuOpenned : NodePath = NodePath("")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_up(extra_arg_0:NodePath):
	print ("DEBUG : Trying to open %s",extra_arg_0)
	var newPath : String
	var separator : String = ""
	for i in extra_arg_0.get_name_count()-1:
		newPath = newPath + separator + extra_arg_0.get_name(i+1)
		separator = "/"
	print ("DEBUG : newPatrh %s",newPath)
	var currentSubMenuNode:CanvasItem
	var nodePath = NodePath(newPath)
	if (!currentSubMenuOpenned.is_empty()):
		currentSubMenuNode = get_node(currentSubMenuOpenned)
		currentSubMenuNode.set("visible",false)		
	if (currentSubMenuOpenned!=nodePath):
		currentSubMenuOpenned=nodePath
		currentSubMenuNode = get_node(currentSubMenuOpenned)
		currentSubMenuNode.set("visible",true)
	else:
		currentSubMenuOpenned=NodePath("")
		
func close_submenu():
	if (!currentSubMenuOpenned.is_empty()):
		var currentSubMenuNode:CanvasItem
		currentSubMenuNode = get_node(currentSubMenuOpenned)
		currentSubMenuNode.set("visible",false)		
	


