extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	randomize()

func new_game():
	$Stick1.start()
	$Stick2.start()
	Score.score = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Ball_color_changed():
	pass # Replace with function body.
