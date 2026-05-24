extends Area2D

@export var camera: Node

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Worm"):
		body.get_parent().visible = false
		body.get_parent().process_mode = Node.PROCESS_MODE_DISABLED
		camera.speed = 0
