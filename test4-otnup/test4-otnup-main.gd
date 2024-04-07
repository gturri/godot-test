extends Node2D

var deckScene = preload("res://test4-otnup/Deck.tscn")
var decks = Array()
var currentPlayer = 0
var numberPlayers = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	createDeck()
	createDeck()

func createDeck():
	var deck = deckScene.instantiate()
	add_child(deck)
	decks.append(deck)

func _input(event):
	if event.is_action_pressed("select_tile"):
		var mouse_pos = get_global_mouse_position()
		var tile_pos = $TileMap.local_to_map(mouse_pos)
		var card = decks[currentPlayer].draw()
		var tile = Vector2i(card, currentPlayer)
		print("tempGT: set_cell with tile " + str(tile))
		$TileMap.set_cell(0, tile_pos, 1, tile)
		currentPlayer = (currentPlayer + 1) % numberPlayers

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
