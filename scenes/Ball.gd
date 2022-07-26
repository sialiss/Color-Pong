extends Area2D

export var DEFAULT_SPEED = 350
signal color_changed

var direction = Vector2.LEFT
var stopped = false
var _speed = DEFAULT_SPEED

onready var screen_size = get_viewport_rect().size

func _process(delta):
	_speed += delta
	if not stopped:
		translate(_speed * delta * direction)

	var ball_pos = position
	if (ball_pos.y < 0 and direction.y < 0) or (ball_pos.y > screen_size.y and direction.y > 0):
		direction.y = -direction.y

	if ball_pos.x < 0:
		reset_ball(false)
	if ball_pos.x > screen_size.x:
		reset_ball(true)

func reset_ball(for_left):
	if for_left:
		direction = Vector2.LEFT
		position = screen_size / 2 + Vector2(-100, 0)
	else:
		direction = Vector2.RIGHT
		position = screen_size / 2 + Vector2(100, 0)
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
	emit_signal("color_changed")

func _on_Area2D_body_entered(body):
	if body.name == "Stick1" or body.name == "Stick2":
		change_color()
		bounce(body.left, randf())
	else:
		var left_side = true
		if position.x < (screen_size.x / 2):
			left_side = false
		bounce(left_side, randf())
