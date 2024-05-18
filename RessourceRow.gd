extends GridContainer

var ressourceList:Dictionary
var stocks:GridContainer 
var turns:GridContainer 
@export var ressourceItem:String

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_node("RessourceList").get_children():
		ressourceList[child.name]=child
	stocks = get_node("CapitalRessourceRow")
	turns = get_node("TurnRessourceRow")

func getRessource(ressource):
	return ressourceList[ressource]

func registerRessource(ressource,card):
	ressourceList[ressource].registerCard(card)

func unregisterRessource(ressource,card):
	ressourceList[ressource].unregisterCard(card)

func add_in_stock(ressource):
	var new_stock = load(ressourceItem).instantiate()
	new_stock.texture = ressourceList[ressource].texture
	stocks.add_child(new_stock)

func remove_from_stock(ressource):
	pass

func add_in_turn(ressource):
	pass

func remove_from_turn(ressource):
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
