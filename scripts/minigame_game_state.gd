extends CanvasLayer

@export var camera: Node
@export var charBody2D: Node
@onready var music = $AudioStreamPlayer

func game_over(body):
	print(body)
	body.get_parent().dead = true
	body.get_parent().process_mode = Node.PROCESS_MODE_DISABLED
	camera.speed = 0
	var tween = get_tree().create_tween()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	visible = true
	tween.tween_property(music, "pitch_scale", 0.25, 2.0)
	tween.tween_property(music, "volume_db", -80.0, 2.0)
	await tween.finished
	music.queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Worm"):
		game_over(body)
	
func _process(delta: float) -> void:
	if !visible:
		return
	if Input.is_action_just_pressed("Click"):
		get_tree().reload_current_scene()

func screen_exited() -> void:
	game_over(charBody2D)
