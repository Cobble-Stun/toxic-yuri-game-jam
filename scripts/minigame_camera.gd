extends CharacterBody2D

var speed: float = -60.0

func _process(delta: float) -> void:
	velocity.y = lerp(velocity.y, speed, delta * 2)
	move_and_slide()
