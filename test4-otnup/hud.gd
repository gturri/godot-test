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
	__gameEnded()

func onPlayerWon(player: int) -> void:
	$MainMessage.text = "Player " + str(player) + " won!"
	$MainMessage.show()
	__gameEnded()

func __gameEnded() -> void:
	$NewGameButton.show()
	$NextCard.hide()
	$NextCardLabel.hide()

func onNewNextCard(card: Card, texture: Texture2D) -> void:
	$NextCard.set_texture(texture)

func _on_new_game_button_pressed():
	$NewGameButton.hide()
	$MainMessage.hide()
	$HintMessage.hide()
	$NextCard.show()
	$NextCardLabel.show()
	startGame.emit()
