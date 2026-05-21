extends Control

@onready var loadSlotScene = preload("res://prefabs/UI/load_slot.tscn")
@onready var animPlayer = $AnimationPlayer
@onready var buttons = $Buttons
@onready var savePrompt = $"Save Prompt"
@onready var saveGame = $"Save Game"
@onready var options = $Options
@onready var loadGame = $"Load Game"
@onready var loadSlotParent = $"Load Game/Scroll Container/Load Slots"
@onready var saveWarning = $"Save Game/Save Warning"
var saveName: String
@onready var scenePlayer = get_parent()

@onready var textVolumeValue = $"Options/Options/Text Volume/Label"
@onready var sfxVolumeValue = $"Control/Options/SFX Volume/Label"
@onready var musicVolumeValue = $"Control/Options/Music Volume/Label"
@onready var textSpeedValue = $"Control/Options/Text Speed/Label"
@onready var autoProgressValue = $"Control/Options/Auto Progress Speed/Label"

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
	
func _on_line_edit_text_changed(new_text: String) -> void:
	saveName = new_text
	
func toggle_save() -> void:
	buttons.visible = !buttons.visible
	saveGame.visible = !saveGame.visible
	
func check_overwrite() -> void:
	if saveName == "" or null:
		saveWarning.visible = true
		return
	
	if FileAccess.file_exists("user://" + saveName + ".json"):
		toggle_save_prompt()
		return
	SaveSystem.save_game(saveName)
	toggle_save()
	
func overwrite_save() -> void:
	saveGame.visible = false
	savePrompt.visible = false
	SaveSystem.save_game(saveName)
	
func toggle_save_prompt() -> void:
	savePrompt.visible = !savePrompt.visible
	saveGame.visible = !saveGame.visible
	
func toggle_load_game() -> void:
	buttons.visible = !buttons.visible
	loadGame.visible = !loadGame.visible
	var saves = SaveSystem.read_save_data()
	for save in saves:
		var image = SaveSystem.read_save_image(save)
		var slot = loadSlotScene.instantiate()
		loadSlotParent.add_child(slot)
		slot.get_node("Name").text = save
		slot.get_node("DateTime").text = saves[save]["date_and_time"]
		slot.get_node("TextureRect").texture = image
		slot.pressed.connect(load_game.bind(save))
	
func load_game(name: String):
	SaveSystem.load_game(name)
	get_tree().change_scene_to_file("res://scenes/Stage.tscn")
	
func toggle_options() -> void:
	buttons.visible = !buttons.visible
	options.visible = !options.visible
	
func _on_quit_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Main Menu.tscn")
	
func _on_quit_game_pressed() -> void:
	get_tree().quit()

func change_text_volume(value: float) -> void:
	Globals.textVolume = value-72
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Text"), Globals.textVolume)
	textVolumeValue.text = str(value)
	
func change_music_volume(value: float):
	Globals.musicVolume = value-72
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), Globals.musicVolume)
	musicVolumeValue.text = str(value)
	
func change_sound_volume(value: float):
	Globals.sfxVolume = value-72
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), Globals.sfxVolume)
	sfxVolumeValue.text = str(value)

func change_text_speed(value: float):
	Globals.textSpeed = value
	textSpeedValue.text = str(value)
	
func change_auto_progress_speed(value: float):
	Globals.textAutoProgressSpeed = value
	autoProgressValue.text = str(value)
	
func save_changes():
	SaveSystem.save_settings()
