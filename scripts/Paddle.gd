extends KinematicBody2D

var mov_left : bool = false
var mov_right : bool = false

func _ready():
	pass # Replace with function body.

func _input(event):
	self.mov_left = Input.is_action_pressed("ui_left")
	self.mov_right = Input.is_action_pressed("ui_right")

func _process(delta):
	if self.mov_left:
		move_and_collide(Vector2(-5, 0))
	if self.mov_right:
		move_and_collide(Vector2(5, 0))
