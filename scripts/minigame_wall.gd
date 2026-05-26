extends Area2D

@export var camera: Node
@export var gameState: Node

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Worm"):
		body.get_parent().dead = true
		body.get_parent().process_mode = Node.PROCESS_MODE_DISABLED
		camera.speed = 0
		gameState.game_over()
