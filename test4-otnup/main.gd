extends Node

var gameSceneResource = preload("res://test4-otnup/game.tscn")
var gameSceneInstance

func onNewGame():
	if gameSceneInstance:
		gameSceneInstance.free()
	gameSceneInstance = gameSceneResource.instantiate()
	add_child(gameSceneInstance)
