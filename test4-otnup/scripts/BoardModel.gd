class_name BoardModel

var cardsPlayed = {}
static var maxBoardDimension = 6
static var nbToAlignToWin = 4

var xmin = null
var xmax = null
var ymin = null
var ymax = null

signal hintMessage(message: String)

func putCard(cardPos: Vector2i, card: Card):
	cardsPlayed[cardPos] = card
	__updateBoardDimension(cardPos)

func __updateBoardDimension(cardPos: Vector2i):
	if xmin == null:
		xmin = cardPos.x
		xmax = cardPos.x
		ymin = cardPos.y
		ymax = cardPos.y
		return
	if xmin > cardPos.x:
		xmin = cardPos.x
	if xmax < cardPos.x:
		xmax = cardPos.x
	if ymin > cardPos.y:
		ymin = cardPos.y
	if ymax < cardPos.y:
		ymax = cardPos.y
	print("board limits: x=[" + str(xmin) + ", " + str(xmax) + "], y=[" + str(ymin) + ", " + str(ymax) + "]")

func canPutCard(cardPos: Vector2i, card: Card):
	if cardsPlayed.is_empty():
		print("The board is empty, any move is legal")
		return true
	return __inBoardLimits(cardPos) \
	 and __isNearAnExistingCard(cardPos) \
	 and __onEmptyCellOrIsBiggerThanOpponentCard(cardPos, card)
	
func __isNearAnExistingCard(cardPos: Vector2i):
	if cardsPlayed.has(cardPos):
		return true
	for neighbor in __getNineNeighbors(cardPos):
		if cardsPlayed.has(neighbor):
			return true
	__emitHintMessage("ERR: not near an existing card")
	return false

func __getNineNeighbors(cardPos: Vector2i):
	return [
		Vector2i(cardPos.x-1, cardPos.y-1),
		Vector2i(cardPos.x-1, cardPos.y  ),
		Vector2i(cardPos.x-1, cardPos.y+1),
		Vector2i(cardPos.x  , cardPos.y-1),
		Vector2i(cardPos.x  , cardPos.y  ),
		Vector2i(cardPos.x  , cardPos.y+1),
		Vector2i(cardPos.x+1, cardPos.y-1),
		Vector2i(cardPos.x+1, cardPos.y  ),
		Vector2i(cardPos.x+1, cardPos.y+1),
	]

func __inBoardLimits(cardPos: Vector2i):
	if cardPos.x - xmin < maxBoardDimension and \
	 xmax - cardPos.x < maxBoardDimension and \
	 cardPos.y - ymin < maxBoardDimension and \
	 ymax - cardPos.y < maxBoardDimension:
		return true;
	else:
		__emitHintMessage("ERR: not in the board limits")
		return false

func __onEmptyCellOrIsBiggerThanOpponentCard(cardPos: Vector2i, card: Card):
	if cardsPlayed.has(cardPos):
		var existingCard: Card = cardsPlayed[cardPos]
		if existingCard.player == card.player:
			__emitHintMessage("ERR: a player cannot play on his or her own card")
			return false
		if card.cardValue > existingCard.cardValue:
			return true
		else:
			__emitHintMessage("ERR: card is not bigger than the existing one")
			return false
	return true

func hasJustWon(lastCardPos: Vector2i):
	var player = cardsPlayed[lastCardPos].player
	return __hasJustWonInGivenDirection(lastCardPos, player, Vector2i(1, 0)) \
	 or __hasJustWonInGivenDirection(lastCardPos, player, Vector2i(1, 1)) \
	 or __hasJustWonInGivenDirection(lastCardPos, player, Vector2i(0, 1)) \
	 or __hasJustWonInGivenDirection(lastCardPos, player, Vector2i(-1, 1))

func __hasJustWonInGivenDirection(lastCardPos: Vector2i, player: int, directionToCheck: Vector2i):
	var nbAligned = 1 # Start at 1 because the card at lastCardPos is supposed to belong to the current player
	var nextPosToCheck = lastCardPos + directionToCheck
	while nbAligned < nbToAlignToWin and cardsPlayed.has(nextPosToCheck) and cardsPlayed[nextPosToCheck].player == player:
		nbAligned += 1
		nextPosToCheck += directionToCheck
	nextPosToCheck = lastCardPos - directionToCheck
	while nbAligned < nbToAlignToWin and cardsPlayed.has(nextPosToCheck) and cardsPlayed[nextPosToCheck].player == player:
		nbAligned += 1
		nextPosToCheck -= directionToCheck
	return nbAligned == nbToAlignToWin

func __emitHintMessage(message: String) -> void:
	print(message)
	hintMessage.emit(message)
