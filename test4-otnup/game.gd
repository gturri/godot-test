extends Node2D

var decks: Array[Deck] = []
var currentPlayer: int = 0
var numberPlayers: int = 2

var nextCard: Card

var isGameCompleted: bool = false

@export var timeInSecondsBetweenTwoConsecutiveCards = 0.2
var playedACardRecently: bool = false # to avoid playing two cards in a row because of a misclick

signal playerWon(player: int)
signal gameDraw
signal showHint(message: String)
signal nextCardDrawn(card: Card, texture: Texture2D)

# Called when the node enters the scene tree for the first time.
func _ready():
	for player in range(numberPlayers): decks.append(Deck.new(player))
	__drawNextCard()

func _input(event):
	if isGameCompleted or playedACardRecently:
		return
	if event.is_action_pressed("select_tile"):
		var mouse_pos = get_global_mouse_position()
		var tile_pos: Vector2i = $BoardView.clickPosToCardPos(mouse_pos)
		if not $BoardModel.canPutCard(tile_pos, nextCard):
			return
		$BoardView.putCard(tile_pos, nextCard)
		$BoardModel.putCard(tile_pos, nextCard)

		if $BoardModel.hasJustWon(tile_pos):
			print("Player just won")
			isGameCompleted = true
			playerWon.emit(currentPlayer)
		elif __areDecksEmpty():
			print("No cards left for anyone")
			isGameCompleted = true
			gameDraw.emit()
		else:
			currentPlayer = (currentPlayer + 1) % numberPlayers
			__drawNextCard()
			playedACardRecently = true
			await get_tree().create_timer(timeInSecondsBetweenTwoConsecutiveCards).timeout
			playedACardRecently = false

func __drawNextCard():
	nextCard = decks[currentPlayer].draw()
	nextCardDrawn.emit(nextCard, $BoardView.getCardTexture(nextCard))
	print("next card: " + str(nextCard))

func __areDecksEmpty():
	for deck in decks:
		if not deck.isEmpty():
			return false
	return true

func _on_board_model_hint_message(message):
	showHint.emit(message) # Replace with function body.
