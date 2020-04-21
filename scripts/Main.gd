extends Node2D

export(PackedScene) var brickScn = preload("res://scenes/Brick.tscn")
export(Vector2) var brickGridSize = Vector2(5, 8)

func _ready() -> void:
	
	for i in range(0, self.brickGridSize.x):
		for j in range(0, self.brickGridSize.y):
			var brick = self.brickScn.instance()
			var b_size = Vector2(100, 40)
		
			brick.position = b_size * Vector2(i, j) + Vector2(100, 90)
			
			add_child(brick)
