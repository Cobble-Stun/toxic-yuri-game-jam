extends Node2D

@onready var animPlayer = $AnimationPlayer

func _ready() -> void:
	animPlayer.play("fade in")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
