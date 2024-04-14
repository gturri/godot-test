extends CanvasLayer


signal startGame

func showHintMessage(text) -> void:
	$HintMessage.text = text
	$HintMessage.show()
	await get_tree().create_timer(2.0).timeout
	$HintMessage.hide()

func onGameDraw() -> void:
	$MainMessage.text = "Draw"
	$MainMessage.show()
	$NewGameButton.show()

func onPlayerWon(player: int) -> void:
	$MainMessage.text = "Player " + str(player) + " won!"
	$MainMessage.show()
	$NewGameButton.show()

func __gameEnded() -> void:
	$NewGameButton.show()

func _on_new_game_button_pressed():
	$NewGameButton.hide()
	$MainMessage.hide()
	$HintMessage.hide()
	startGame.emit()
