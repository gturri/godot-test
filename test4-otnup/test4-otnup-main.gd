extends Node2D

var deckScene = preload("res://test4-otnup/Deck.tscn")
var deck

# Called when the node enters the scene tree for the first time.
func _ready():
	deck = deckScene.instantiate()
	add_child(deck)

func _input(event):
	if event.is_action_pressed("select_tile"):
		var mouse_pos = get_global_mouse_position()
		var tile_pos = $TileMap.local_to_map(mouse_pos)
		var card = deck.draw()
		$TileMap.set_cell(0, tile_pos, 0, Vector2i(card, 0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
