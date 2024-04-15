extends TileMap

const sourceId = 1

func clickPosToCardPos(clickPos: Vector2) -> Vector2i:
	return local_to_map(clickPos)

func putCard(cardPos: Vector2i, card: Card) -> void:
	var tile = Vector2i(card.cardValue, card.player)
	set_cell(0, cardPos, sourceId, tile)

func getCardTexture(card: Card) -> Texture2D:
	var source: TileSetAtlasSource = get_tileset().get_source(sourceId)
	var textureRegion: Rect2i = source.get_tile_texture_region(Vector2i(card.cardValue, card.player))
	var tileImage: Image = source.texture.get_image().get_region(textureRegion)
	return ImageTexture.create_from_image(tileImage)

