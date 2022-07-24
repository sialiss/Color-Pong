extends KinematicBody2D

export var left = false
export var up = ""
export var down = ""
export var speed = 400
export(NodePath) var StartPosition

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = 0

	if Input.get_axis(up, down):
		velocity = Input.get_axis(up, down) * speed

	position.y += velocity * delta
	# position = lerp(position, position + Vector2(0, 1) * velocity * delta, 0.9)
	position.y = clamp(position.y, 0, screen_size.y)

func start():
	position = get_node(StartPosition).position
	show()
	$CollisionShape2D.disabled = false
