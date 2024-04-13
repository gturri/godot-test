extends TileMap

func clickPosToCardPos(clickPos: Vector2) -> Vector2i:
	return local_to_map(clickPos)

func putCard(cardPos: Vector2i, cardValue: int, player: int) -> void:
	var tile = Vector2i(cardValue, player)
	set_cell(0, cardPos, 1, tile)
