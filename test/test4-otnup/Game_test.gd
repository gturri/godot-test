# GdUnit generated TestSuite
class_name Game_Test
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

var eventsReceived := []

func test_EmitHintMessage() -> void:
	# Setup
	var runner := scene_runner("res://test4-otnup/game.tscn")
	runner.scene().timeInSecondsBetweenTwoConsecutiveCards = 0
	runner.scene().showHint.connect(__listener)

	await __tryPutCell(runner, Vector2i(0, 0))
	## Precondition: no hint should have been received so far
	assert_int(eventsReceived.size()).is_equal(0)

	# Act (click on cell not adjacent to an existing card, to get a hint message accordingly)
	await __tryPutCell(runner, Vector2i(129, 0))

	# Assert
	assert_int(eventsReceived.size()).is_equal(1)

func __tryPutCell(runner, clickPos: Vector2i) -> void:
	runner.set_mouse_pos(clickPos)
	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	await await_idle_frame()

func __listener(event):
	eventsReceived.append(event)
