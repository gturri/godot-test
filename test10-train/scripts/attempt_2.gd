extends Node2D

var path1: Path2D
var path2: Path2D
var path3: Path2D
var path4: Path2D
var map := {}

@export var speed: float = 1

var currentPath: Path2D
var currentRatio: float


# Called when the node enters the scene tree for the first time.
func _ready():
	path1 = __build_path2D(Vector2(0, 0), Vector2(0, 100))
	path2 = __build_path2D(Vector2(0, 100), Vector2(100, 100))
	path3 = __build_path2D(Vector2(100, 100), Vector2(100, 0))
	path4 = __build_path2D(Vector2(100, 0), Vector2(0, 0))

	map[path1] = {}
	map[path1]["next"] = path2
	map[path1]["prev"] = path4
	map[path2] = {}
	map[path2]["next"] = path3
	map[path2]["prev"] = path1
	map[path3] = {}
	map[path3]["next"] = path4
	map[path3]["prev"] = path2
	map[path4] = {}
	map[path4]["next"] = path1
	map[path4]["prev"] = path3

	currentPath = path1
	currentRatio = 0.0
	__set_train_position()

func __build_path2D(point1: Vector2, point2: Vector2) -> Path2D:
	var path = Path2D.new()
	path.set_curve(__build_curve2D(point1, point2))

	var pathFollow2D = PathFollow2D.new()
	pathFollow2D.set_name("PathFollow2D")

	path.add_child(pathFollow2D, true)
	add_child(path)
	return path

func __build_curve2D(point1: Vector2, point2: Vector2) -> Curve2D:
	var curve = Curve2D.new()
	curve.add_point(point1)
	curve.add_point(point2)
	return curve

func __set_train_position() -> void:
	var pathFollow: PathFollow2D = currentPath.get_node("PathFollow2D")
	pathFollow.set_progress_ratio(currentRatio)
	$Train.position = pathFollow.position

func _process(delta):
	currentRatio += speed * delta
	if currentRatio > 1:
		currentRatio -= 1
		currentPath = map[currentPath]["next"]
	__set_train_position()
