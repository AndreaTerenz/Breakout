extends Node2D

export(PackedScene) var brickScn = preload("res://scenes/Brick.tscn")
export(PackedScene) var ballScn = preload("res://scenes/Ball.tscn")
export(Vector2) var brickGridSize = Vector2(4, 4)

onready var screenSize : Vector2 = get_viewport_rect().size
onready var ballStartingPos : Vector2 = Vector2(self.screenSize.x/2 - 60, 420)

var brickCount : int = -1
var ball : Node = null
var brickSpacing_V : float = 20
var brickOffset : Vector2 = Vector2(40, 250)

func _ready() -> void:
	reset()

func reset() -> void:
	spawnGrid()
	spawnBall()
	
func spawnBall() -> void:
	if (ball != null):
		ball.queue_free()

	ball = ballScn.instance()
	ball.position = self.ballStartingPos
	ball.connect("hitBrick", self, "ballHitBrick")
	call_deferred("add_child", ball)
	
func spawnGrid() -> void:
	self.brickCount = 0
	
	var gridXf = self.screenSize.x - self.brickOffset.x
	var gridX_delta = abs(gridXf - self.brickOffset.x)
	var columnWidth = gridX_delta / self.brickGridSize.x
	
	self.brickOffset.x += (columnWidth - Brick.brickSize.x) / 2
	var brickSpacing : Vector2 = Vector2((columnWidth - Brick.brickSize.x), self.brickSpacing_V)
	
	for i in range(0, self.brickGridSize.x):
		for j in range(0, self.brickGridSize.y):
			self.brickCount += 1
			
			var brick = self.brickScn.instance()
			brick.setPos(self.brickOffset + Vector2(i, j)*(Brick.brickSize + brickSpacing))
			call_deferred("add_child", brick)
			
	print(self.brickCount)

func ballHitBrick(brick : Node) -> void:
	call_deferred("remove_child", brick)
	brick.queue_free()
	self.brickCount -= 1
	
	if (self.brickCount <= 0):
		reset()

func _death_zone_entered(body: Node) -> void:
	if (body == ball):
		spawnBall()
