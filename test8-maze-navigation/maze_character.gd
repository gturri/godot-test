extends CharacterBody2D

var movement_speed: float = 200.0
var movement_target_position: Vector2 = Vector2(60.0,180.0)

func _ready():
	$NavigationAgent2D.path_desired_distance = 10.0
	$NavigationAgent2D.target_desired_distance = 1.0

func set_movement_target(movement_target: Vector2):
	$NavigationAgent2D.target_position = movement_target

func _physics_process(delta):
	if $NavigationAgent2D.is_navigation_finished():
		$AnimatedSprite2D.stop()
		return

	$AnimatedSprite2D.play()
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = $NavigationAgent2D.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()
