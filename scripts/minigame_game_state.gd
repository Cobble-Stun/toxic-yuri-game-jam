extends CanvasLayer

@onready var music = $AudioStreamPlayer

func game_over():
	var tween = get_tree().create_tween()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	visible = true
	tween.tween_property(music, "pitch_scale", 0.25, 2.0)
	tween.tween_property(music, "volume_db", -80.0, 2.0)
	await tween.finished
	music.queue_free()
	
func _process(delta: float) -> void:
	if !visible:
		return
	if Input.is_action_just_pressed("Click"):
		get_tree().reload_current_scene()
