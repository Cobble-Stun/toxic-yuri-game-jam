extends CharacterBody2D

@export var worm: Node
var speed: float = -100.0

func _process(delta: float) -> void:
	velocity.y = lerp(velocity.y, speed, delta * 2)
	worm.mousePos += velocity * delta
	move_and_slide()
