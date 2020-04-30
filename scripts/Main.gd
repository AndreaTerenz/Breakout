extends Node2D

signal scored
signal died
signal reset

export(PackedScene) var brickScn = preload("res://scenes/Brick.tscn")
export(PackedScene) var ballScn = preload("res://scenes/Ball.tscn")
export(String, FILE, "*.txt") var gridFile = "res://scripts/grid.txt"

onready var screenSize : Vector2 = get_viewport_rect().size
onready var ballStartingPos : Vector2 = Vector2(self.screenSize.x/2 - 60, 420)

var grid : Array = []
var brickCount : int = -1
var ball : Node = null
var brickSpacing_V : float = 20
var brickOffset : Vector2 = Vector2(40, 100)

func onStartSignal() -> void:
	$Paddle.show()
	reset()
	
func reset() -> void:
	emit_signal("reset")
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
	
	if (self.grid.size() <= 0):
		grid = loadGridFile()
	
	var gridSize = Vector2.ZERO
	
	gridSize.x = grid[0].size()
	gridSize.y = grid.size()
	
	var gridXf = self.screenSize.x - self.brickOffset.x
	var gridX_delta = abs(gridXf - self.brickOffset.x)
	var columnWidth = gridX_delta / gridSize.x
	
	self.brickOffset.x += (columnWidth - Brick.brickSize.x) / 2
	var brickSpacing : Vector2 = Vector2((columnWidth - Brick.brickSize.x), self.brickSpacing_V)
	
	for i in range(0, gridSize.x):
		for j in range(0, gridSize.y):
			if (grid[j][i] == 1):
				self.brickCount += 1
				
				var brick = self.brickScn.instance()
				brick.setPos(self.brickOffset + Vector2(i, j)*(Brick.brickSize + brickSpacing))
				call_deferred("add_child", brick)
			
	print(self.brickCount)

func ballHitBrick(brick : Node) -> void:
	call_deferred("remove_child", brick)
	brick.queue_free()
	self.brickCount -= 1
	emit_signal("scored")
	
	if (self.brickCount <= 0):
		reset()

func loadGridFile() -> Array:
	var f : File = File.new()
	var err = f.open(self.gridFile, File.READ)
	var output : Array = []
	
	if err == OK:
		var text = f.get_as_text()
		var lines : Array = text.split("\n", false)
		
		for i in range(0, lines.size()):
			var content : Array = lines[i].to_ascii()
			for j in range(0, content.size()):
				content[j] -= 48 #ascii code for '0'
				
			output.append(content)
	
	f.close()
	return output

func _death_zone_entered(body: Node) -> void:
	if (body == ball):
		emit_signal("died")
		spawnBall()
