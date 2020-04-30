extends KinematicBody2D

export(float, 2.0, 10.0, 0.2) var speed = 5.0

var mov_left : bool = false
var mov_right : bool = false

func _input(_event):
	if (self.visible):
		self.mov_left = Input.is_action_pressed("ui_left")
		self.mov_right = Input.is_action_pressed("ui_right")

func _process(_delta):
	if self.mov_left:
		move_and_collide(Vector2(-speed, 0))
	if self.mov_right:
		move_and_collide(Vector2(speed, 0))
