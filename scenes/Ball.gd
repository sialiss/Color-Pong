extends Area2D

export var DEFAULT_SPEED = 350

var direction = Vector2.LEFT
var stopped = false
var _speed = DEFAULT_SPEED

onready var _screen_size = get_viewport_rect().size

func _process(delta):
	_speed += delta
	if not stopped:
		translate(_speed * delta * direction)

	var ball_pos = position
	if (ball_pos.y < 0 and direction.y < 0) or (ball_pos.y > _screen_size.y and direction.y > 0):
		direction.y = -direction.y

func _reset_ball(for_left):
	position = _screen_size / 2
	if for_left:
		direction = Vector2.LEFT
	else:
		direction = Vector2.RIGHT
	_speed = DEFAULT_SPEED

func bounce(left, random):
	if left:
		direction.x = abs(direction.x)
	else:
		direction.x = -abs(direction.x)

	direction.y = random * 2.0 - 1
	direction = direction.normalized()

func change_color():
	var colors = ["#ffffff", "#9e0000", "#2139ff", "#00a212", "#f2ff0b", "#ff5c77", "#ff5a47", "#9932cc", "#3b83bd", "#00ebc4"]
	modulate = colors[randi() % colors.size()]

func _on_Area2D_body_entered(body):
	bounce(body.left, randf())
	change_color()
