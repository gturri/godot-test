# GdUnit generated TestSuite
class_name BoardModelTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

const player0 = 0
const player1 = 1

func test_canPutAnyCardAnywhereOnAnEmptyBoard() -> void:
	var sut: BoardModel = BoardModel.new()
	assert_bool(sut.canPutCard(Vector2i(0, 0), Card.new(player0, 3))).is_equal(true)
	assert_bool(sut.canPutCard(Vector2i(-2, -2), Card.new(player1, 9))).is_equal(true)
	assert_bool(sut.canPutCard(Vector2i(10000, 666), Card.new(player0, 3))).is_equal(true)

func test_canPutCardsOnlyInTheLimitsOfTheBoard() -> void:
	# Setup
	var sut: BoardModel = BoardModel.new()
	sut.putCard(Vector2i(10, 100), Card.new(player0, 0))
	sut.putCard(Vector2i(11, 100), Card.new(player0, 0))
	sut.putCard(Vector2i(12, 100), Card.new(player0, 0))
	sut.putCard(Vector2i(13, 100), Card.new(player0, 0))
	sut.putCard(Vector2i(14, 100), Card.new(player0, 0))
	sut.putCard(Vector2i(15, 100), Card.new(player0, 0))

	sut.putCard(Vector2i(10, 101), Card.new(player0, 0))
	sut.putCard(Vector2i(10, 102), Card.new(player0, 0))
	sut.putCard(Vector2i(10, 103), Card.new(player0, 0))
	sut.putCard(Vector2i(10, 104), Card.new(player0, 0))
	sut.putCard(Vector2i(10, 105), Card.new(player0, 0))

	# Assert
	assert_bool(sut.canPutCard(Vector2i(11, 101), Card.new(player0, 3))).is_equal(true)
	assert_bool(sut.canPutCard(Vector2i(12, 101), Card.new(player0, 3))).is_equal(true)

	assert_bool(sut.canPutCard(Vector2i(9, 100), Card.new(player0, 3))).is_equal(false)
	assert_bool(sut.canPutCard(Vector2i(16, 100), Card.new(player0, 3))).is_equal(false)
	assert_bool(sut.canPutCard(Vector2i(10, 99), Card.new(player0, 3))).is_equal(false)
	assert_bool(sut.canPutCard(Vector2i(10, 106), Card.new(player0, 3))).is_equal(false)
