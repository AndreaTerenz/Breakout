extends RigidBody2D

export(float, 40, 300,  0.5) var startVelMult = 80

func _ready() -> void:
	set_linear_velocity(Vector2.ONE * self.startVelMult)
