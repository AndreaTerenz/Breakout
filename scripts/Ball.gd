extends RigidBody2D

signal hitBrick(brck)

export(float, 40, 300,  0.5) var startVelMult = 80

func _ready() -> void:
	set_linear_velocity(Vector2.ONE * self.startVelMult)

func _on_Ball_body_entered(body: Node) -> void:
	if (body.get_name().find("brick") != -1):
		emit_signal("hitBrick", body)
