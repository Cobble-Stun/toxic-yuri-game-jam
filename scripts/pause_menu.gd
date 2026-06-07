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

@onready var textVolumeSlider = $"Options/Options/Text Volume/Text Volume Slider"
@onready var sfxVolumeSlider = $"Options/Options/SFX Volume/SFX Volume Slider"
@onready var musicVolumeSlider = $"Options/Options/Music Volume/Music Volume Slider"
@onready var textSpeedSlider = $"Options/Options/Text Speed/Text Speed Slider"
@onready var autoProgressSlider = $"Options/Options/Auto Progress Speed/Auto Progress Speed Slider"
@onready var textVolumeValue = $"Options/Options/Text Volume/Label"
@onready var sfxVolumeValue = $"Options/Options/SFX Volume/Label"
@onready var musicVolumeValue = $"Options/Options/Music Volume/Label"
@onready var textSpeedValue = $"Options/Options/Text Speed/Label"
@onready var autoProgressValue = $"Options/Options/Auto Progress Speed/Label"

func _ready() -> void:
	animPlayer.play("Hidden")
	reset_settings()

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
			buttons.visible = true
			savePrompt.visible = false
			saveGame.visible = false
			options.visible = false
			loadGame.visible = false
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
	
	for save in loadSlotParent.get_children():
		save.queue_free()
	
	var saves = SaveSystem.read_save_data()
	for save in saves:
		var image = SaveSystem.read_save_image(save)
		var slot = loadSlotScene.instantiate()
		loadSlotParent.add_child(slot)
		slot.get_node("Name").text = save
		slot.get_node("DateTime").text = saves[save]["date_and_time"]
		slot.get_node("TextureRect").texture = image
		slot.pressed.connect(load_game.bind(save))
	
func load_game(saveName: String):
	SaveSystem.load_game(saveName)
	get_tree().change_scene_to_file("res://scenes/Stage.tscn")
	
func toggle_options() -> void:
	buttons.visible = !buttons.visible
	options.visible = !options.visible
	if options.visible:
		reset_settings()
	
func _on_quit_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Main Menu.tscn")
	
func _on_quit_game_pressed() -> void:
	get_tree().quit()

func change_text_volume(value: float) -> void:
	textVolumeValue.text = str(value * 100)
	
func change_music_volume(value: float):
	musicVolumeValue.text = str(value * 100)
	
func change_sound_volume(value: float):
	sfxVolumeValue.text = str(value * 100)

func change_text_speed(value: float):
	textSpeedValue.text = str(value)
	
func change_auto_progress_speed(value: float):
	autoProgressValue.text = str(value)
	
func reset_settings():
	textVolumeSlider.value = Globals.textVolume
	sfxVolumeSlider.value = Globals.sfxVolume
	musicVolumeSlider.value = Globals.musicVolume
	textSpeedSlider.value = Globals.textSpeed
	autoProgressSlider.value = Globals.textAutoProgressSpeed
	textVolumeValue.text = str(Globals.textVolume * 100)
	sfxVolumeValue.text = str(Globals.sfxVolume * 100)
	musicVolumeValue.text = str(Globals.musicVolume * 100)
	textSpeedValue.text = str(Globals.textSpeed)
	autoProgressValue.text = str(Globals.textAutoProgressSpeed)
	
func save_changes():
	Globals.textVolume = float(textVolumeValue.text)/100
	Globals.musicVolume = float(musicVolumeValue.text)/100
	Globals.sfxVolume = float(sfxVolumeValue.text)/100
	Globals.textSpeed = float(textSpeedValue.text)
	Globals.textAutoProgressSpeed = float(autoProgressValue.text)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Text"), linear_to_db(Globals.textVolume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(Globals.musicVolume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), linear_to_db(Globals.sfxVolume))
	SaveSystem.save_settings()
