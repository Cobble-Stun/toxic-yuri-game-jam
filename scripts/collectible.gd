extends Area2D

@onready var sound = preload("res://audio/sounds/pickup.wav")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Worm"):
		play_pickup_sound()
		body.get_parent().collect_thing()
		queue_free()

func play_pickup_sound():
	var soundPlayer = AudioStreamPlayer.new()
	get_parent().add_child(soundPlayer)
	soundPlayer.stream = sound
	soundPlayer.play()
	await soundPlayer.finished
	soundPlayer.queue_free()
