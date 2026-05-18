extends Control

@onready var loadSlotScene = preload("res://prefabs/UI/load_slot.tscn")
@onready var saveSlotScene = preload("res://prefabs/UI/save_slot.tscn")
@onready var animPlayer = $AnimationPlayer
@onready var scenePlayer = get_parent()

func _ready() -> void:
	animPlayer.play("Hidden")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("PauseMenu"):
		if visible == false:
			visible = true
			animPlayer.play("Show")
			scenePlayer.preventTextProgress = true
			await animPlayer.animation_finished
			animPlayer.play("Idle")
			return
		if visible == true:
			animPlayer.play("Hide")
			await animPlayer.animation_finished
			scenePlayer.preventTextProgress = false
			visible = false
			return
	
func _on_save_pressed() -> void:
	pass # Replace with function body.
	
func _on_load_pressed() -> void:
	pass # Replace with function body.
	
func _on_options_pressed() -> void:
	pass # Replace with function body.
	
func _on_quit_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Main Menu.tscn")
	
func _on_quit_game_pressed() -> void:
	get_tree().quit()
