extends Node2D

export(PackedScene) var brickScn = preload("res://scenes/Brick.tscn")
export(Vector2) var brickGridSize = Vector2(5, 8)

onready var screenSize : Vector2 = get_viewport_rect().size

var brickSpacing_V : float = 20
var brickOffset : Vector2 = Vector2(40, 90)

func _ready() -> void:
	
	var gridXf = self.screenSize.x - self.brickOffset.x
	var gridX_delta = abs(gridXf - self.brickOffset.x)
	var columnWidth = gridX_delta / self.brickGridSize.x
	
	self.brickOffset.x += (columnWidth - Brick.brickSize.x) / 2
	var brickSpacing : Vector2 = Vector2((columnWidth - Brick.brickSize.x), self.brickSpacing_V)
	
	for i in range(0, self.brickGridSize.x):
		for j in range(0, self.brickGridSize.y):
			var brick = self.brickScn.instance()
			
			brick.position = self.brickOffset + Vector2(i, j)*(Brick.brickSize + brickSpacing)
			
			add_child(brick)
