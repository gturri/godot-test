extends Node

var gameSceneResource = preload("res://test4-otnup/game.tscn")
var gameSceneInstance

func onNewGame():
	if gameSceneInstance:
		gameSceneInstance.free()
	gameSceneInstance = gameSceneResource.instantiate()
	gameSceneInstance.playerWon.connect($HUD.onPlayerWon)
	gameSceneInstance.gameDraw.connect($HUD.onGameDraw)
	gameSceneInstance.showHint.connect($HUD.showHintMessage)
	gameSceneInstance.nextCardDrawn.connect($HUD.onNewNextCard)
	add_child(gameSceneInstance)


