extends Area2D

@export var conditionRessourcesToGet:Array
@export var conditionRessourcesToGetMinAmount:Array
@export var conditionRessourcesToGetMaxAmount:Array
@export var conditionRessourcesToKeep:Array
@export var conditionRessourcesToKeepMinAmount:Array
@export var conditionRessourcesToKeepMaxAmount:Array
@export var instantRessourcesNeeded:Array
@export var instantRessourcesNeededAmount:Array
@export var instantRessourcesGained:Array
@export var instantRessourcesGainedAmount:Array
@export var turnRessourcesNeeded:Array
@export var turnRessourcesNeededAmount:Array
@export var turnRessourcesNeededOptionnal:Array
@export var turnRessourcesNeededOptionnalMaxAmount:Array
@export var turnRessourcesGained:Array
@export var turnRessourcesGainedAmount:Array
@export var turnRessourcesGainedPotential:Array
@export var turnRessourcesGainedPotentialFormula:Array

@export var conditionToGetColor:Color
@export var conditionToKeepColor:Color
@export var instantNeededColor:Color
@export var instantGainedColor:Color
@export var turnNeededColor:Color
@export var turnGainedColor:Color

var RessourceNodes:Array
var parent:Panel

var draggable: bool = false
var is_dragged: bool = false
var drag_offset: Vector2

func assignColor(ress1:int, ress2:int, color1:Color, color2:Color, shift:int):
	var nbGray
	var nbGreen
	var nbRed
	if ress1==0 && ress2==0:
		nbGray = 5
		nbGreen = 0
		nbRed = 0
	elif ress1==0:
		nbGray = 0
		nbGreen = 5
		nbRed = 0
	elif ress2==0:
		nbGray = 0
		nbGreen = 0
		nbRed = 5
	elif ress1+ress2==5:
		nbGray = 0
		nbRed = ress1
		nbGreen = ress2
	else:
		nbGray = 1
		nbGreen = max(ress2,min(5 - nbGray - ress1,2))
		nbRed = max(ress1,min(5 - nbGray - ress2,2))
	print("ress1:%d ress2:%d nbRed:%d ndGray:%d nbGreen:%d" % [ress1,ress2,nbRed,nbGray,nbGreen])
			
	for i in nbRed:
		RessourceNodes[i+shift].color = color1
	for i in nbGreen:
		RessourceNodes[4-i+shift].color = color2
		
# Called when the node enters the scene tree for the first time.
func _ready():
	if conditionRessourcesToGet.size()+conditionRessourcesToKeep.size()>5:
		print("Too many conditions")
		return
	if instantRessourcesNeeded.size()+instantRessourcesGained.size()>5:
		print("Too many instant ressources")
		return
	if turnRessourcesNeeded.size()+turnRessourcesGained.size()>5:
		print("Too many turn ressources")
		return
	parent = get_parent()
	for child in get_node("Sprites").get_children():
		RessourceNodes.append(child)
		

	assignColor(conditionRessourcesToGet.size(),conditionRessourcesToKeep.size(),conditionToGetColor,conditionToKeepColor,0)
		
	for i in conditionRessourcesToGet.size():
		var iconNode = parent.giveRessourceNode(conditionRessourcesToGet[i])
		if iconNode!=null && iconNode.is_class("Sprite2D"):
			RessourceNodes[i].get_child(0).texture = iconNode.texture
			RessourceNodes[i].get_child(0).visible = true
			parent.registerRessource(conditionRessourcesToGet[i],self)
			print ("DEBUG : got conditionRessourcesToGet")
	for i in conditionRessourcesToKeep.size():
		var iconNode = parent.giveRessourceNode(conditionRessourcesToKeep[i])
		if iconNode!=null && iconNode.is_class("Sprite2D"):
			RessourceNodes[4-i].get_child(0).texture = iconNode.texture
			RessourceNodes[4-i].get_child(0).visible = true
			print ("DEBUG : got conditionRessourcesToKeep")

	assignColor(instantRessourcesNeeded.size(),instantRessourcesGained.size(),instantNeededColor,instantGainedColor,5)

	for i in instantRessourcesNeeded.size():
		var iconNode = parent.giveRessourceNode(instantRessourcesNeeded[i])
		if iconNode!=null && iconNode.is_class("Sprite2D"):
			RessourceNodes[5+i].get_child(0).texture = iconNode.texture
			RessourceNodes[5+i].get_child(0).visible = true
			parent.registerRessource(instantRessourcesNeeded[i],self)
			print ("DEBUG : got instantRessourcesNeeded")
	for i in instantRessourcesGained.size():
		var iconNode =  parent.giveRessourceNode(instantRessourcesGained[i])
		if iconNode!=null && iconNode.is_class("Sprite2D"):
			RessourceNodes[9-i].get_child(0).texture = iconNode.texture
			RessourceNodes[9-i].get_child(0).visible = true
			parent.registerRessource(instantRessourcesGained[i],self)
			print ("DEBUG : got instantRessourcesGained")

	assignColor(turnRessourcesNeeded.size(),turnRessourcesGained.size(),turnNeededColor,turnGainedColor,10)

	for i in turnRessourcesNeeded.size():
		var iconNode =  parent.giveRessourceNode(turnRessourcesNeeded[i])
		if iconNode!=null && iconNode.is_class("Sprite2D"):
			RessourceNodes[10+i].get_child(0).texture = iconNode.texture
			RessourceNodes[10+i].get_child(0).visible = true
			parent.registerRessource(turnRessourcesNeeded[i],self)
			print ("DEBUG : got turnRessourcesNeeded")
	for i in turnRessourcesGained.size():
		var iconNode =  parent.giveRessourceNode(turnRessourcesGained[i])
		if iconNode!=null && iconNode.is_class("Sprite2D"):
			RessourceNodes[14-i].get_child(0).texture = iconNode.texture
			RessourceNodes[14-i].get_child(0).visible = true
			parent.registerRessource(turnRessourcesGained[i],self)
			print ("DEBUG : got turnRessourcesGained")

func _on_mouse_entered():
	if !is_dragged:
		draggable = true
		print("DEBUG : Now draggable ...")

func _on_mouse_exited():
	if !is_dragged:
		draggable = false
		print("DEBUG : Now not draggable ...")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			drag_offset = get_global_mouse_position() - global_position
			is_dragged = true
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - drag_offset
		elif Input.is_action_just_released("click"):
			is_dragged = false
			
func getStockInfluence(ressource):
	return 1
	pass

