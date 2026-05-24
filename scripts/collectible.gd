extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Worm"):
		body.get_parent().collect_thing()
		queue_free()
