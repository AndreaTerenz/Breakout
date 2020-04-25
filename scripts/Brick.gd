class_name Brick

extends StaticBody2D

const brickSize : Vector2 = Vector2(50, 20)

func _ready() -> void:
	self.name = "brick"

func setPos(pos : Vector2) -> void:
	self.position = pos
