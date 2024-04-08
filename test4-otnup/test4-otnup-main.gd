extends Node2D

var deckScene = preload("res://test4-otnup/Deck.tscn")
var decks = Array()
var currentPlayer = 0
var numberPlayers = 2
var cardsPlayed = {}
var nextCard
static var maxBoardDimension = 6

var xmin = null;
var xmax = null;
var ymin = null;
var ymax = null

# Called when the node enters the scene tree for the first time.
func _ready():
	createDeck()
	createDeck()
	drawNextCard()

func createDeck():
	var deck = deckScene.instantiate()
	add_child(deck)
	decks.append(deck)

func _input(event):
	if event.is_action_pressed("select_tile"):
		var mouse_pos = get_global_mouse_position()
		var tile_pos = $TileMap.local_to_map(mouse_pos)
		if not canPutCard(tile_pos):
			return
		var tile = Vector2i(nextCard, currentPlayer)
		updateBoardDimension(tile_pos)
		$TileMap.set_cell(0, tile_pos, 1, tile)
		# TODO: check if the player won, or if there are no cards left
		cardsPlayed[tile_pos] = [nextCard, currentPlayer] #TODO: could be cleaner to have an ad hoc class instead of this Array
		currentPlayer = (currentPlayer + 1) % numberPlayers
		drawNextCard()

func updateBoardDimension(tile_pos):
	if xmin == null:
		xmin = tile_pos.x
		xmax = tile_pos.x
		ymin = tile_pos.y
		ymax = tile_pos.y
		return
	if xmin > tile_pos.x:
		xmin = tile_pos.x
	if xmax < tile_pos.x:
		xmax = tile_pos.x
	if ymin > tile_pos.y:
		ymin = tile_pos.y
	if ymax < tile_pos.y:
		ymax = tile_pos.y
	print("board limits: x=[" + str(xmin) + ", " + str(xmax) + "], y=[" + str(ymin) + ", " + str(ymax) + "]")

func drawNextCard():
	nextCard = decks[currentPlayer].draw()
	# TODO: display this message in-game
	print("next card (for player " + str(currentPlayer) + "): " + str(nextCard))

func canPutCard(tile_pos):
	if cardsPlayed.is_empty():
		return true
	if not inBoardLimits(tile_pos):
		print("not in board limit")
		return false
	if cardsPlayed.has(tile_pos):
		var existingCard = cardsPlayed[tile_pos]
		if existingCard[1] == currentPlayer:
			# TODO: display this message in-game
			print("ERR: a player cannot play on his or her own card")
			return false
		if nextCard > existingCard[0]:
			return true
		else:
			print("ERR: card is not bigger than the existing one")
			return false
	# TODO: check that we're near an existing card
	return true

func inBoardLimits(tile_pos):
	print("checking boardLimits with " + str(tile_pos))
	return tile_pos.x - xmin < maxBoardDimension and \
		xmax - tile_pos.x < maxBoardDimension and \
		tile_pos.y - ymin < maxBoardDimension and \
		ymax - tile_pos.y < maxBoardDimension;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
