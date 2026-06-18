extends Area2D

@export var sceneName: String

func _on_body_entered(body: Node2D) -> void:
	SaveSystem.load_scene(sceneName)
	Globals.load_data()
	get_tree().call_deferred("change_scene_to_file", "res://scenes/Stage.tscn")
