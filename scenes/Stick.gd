extends KinematicBody2D

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

	# if velocity.length() > 0:
	# 	velocity = velocity.normalized() * speed
	# 	$AnimatedSprite.play()
	# else:
	# 	$AnimatedSprite.stop()

	position.y += velocity * delta
	# position = lerp(position, position + Vector2(0, 1) * velocity * delta, 0.9)
	position.y = clamp(position.y, 0, screen_size.y)

	# if velocity.x != 0:
	# 	$AnimatedSprite.animation = "walk"
	# 	$AnimatedSprite.flip_v = false
	# 	$AnimatedSprite.flip_h = velocity.x < 0
	# elif velocity.y != 0:
	# 	$AnimatedSprite.animation = "up"
	# 	$AnimatedSprite.flip_v = velocity.y > 0

func start():
	position = get_node(StartPosition).position
	show()
	$CollisionShape2D.disabled = false
