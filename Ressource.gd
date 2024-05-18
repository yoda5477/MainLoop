extends Sprite2D

var global_stock:bool = false # is stocked globally, total display and managed in ressouce row
var local_stock:bool = false # is stocked on teh card, total is display in ressource row
var floored:bool = false #can go below zero without issue, simply floored to zéro in that case

var stock_visible: bool = false #already dislayed ?
var turn_visible: bool = false #already dislayed ?

var turnVariation: int = 0
var stocked:int = 0

var cardInfluenceList: Array
var parent:Node

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if stocked!=0 && !stock_visible:
		parent.ressourceManager.add_in_stock(name)
		stock_visible = true
	if stocked==0 && stock_visible:
		parent.ressourceManager.remove_from_stock(name)
		stock_visible = false
	if turnVariation!=0 && !turn_visible:
		parent.ressourceManager.add_in_turn(name)		
		turn_visible = true
	if turnVariation==0 && turn_visible:
		parent.ressourceManager.remove_from_turn(name)		
		turn_visible = false

func registerCard(card):
	print("registering %s on %s ressource ?" % [card.name,name])
	if !cardInfluenceList.has(card):
		print("registering %s on %s ressource !" % [card.name,name])
		cardInfluenceList.append(card)
		stocked+=card.getStockInfluence(name)

func unregisterCard(card):
	if cardInfluenceList.has(card):
		cardInfluenceList.erase(card)
