extends CanvasLayer

@onready var loadSlotScene = preload("res://prefabs/UI/load_slot.tscn")
@export var bgs: Array[Texture2D]
@onready var primaryMenuButtons = $"Control/Primary Menu Buttons"
@onready var options = $Control/Options
@onready var loadGame = $"Control/Load Game"
@onready var loadSlotParent = $"Control/Load Game/Scroll Container/Load Slots"

@onready var textVolumeSlider = $"Control/Options/Text Volume/Text Volume Slider"
@onready var sfxVolumeSlider = $"Control/Options/SFX Volume/SFX Volume Slider"
@onready var musicVolumeSlider = $"Control/Options/Music Volume/Music Volume Slider"
@onready var textSpeedSlider = $"Control/Options/Text Speed/Text Speed Slider"
@onready var autoProgressSlider = $"Control/Options/Auto Progress Speed/Auto Progress Speed Slider"
@onready var textVolumeValue = $"Control/Options/Text Volume/Label"
@onready var sfxVolumeValue = $"Control/Options/SFX Volume/Label"
@onready var musicVolumeValue = $"Control/Options/Music Volume/Label"
@onready var textSpeedValue = $"Control/Options/Text Speed/Label"
@onready var autoProgressValue = $"Control/Options/Auto Progress Speed/Label"

func _ready() -> void:
	SaveSystem.load_settings()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Text"), Globals.textVolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), Globals.musicVolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), Globals.sfxVolume)
	reset_settings()
		
func start_new_game():
	SaveSystem.load_scene("introductionfish")
	Globals.load_data()
	get_tree().change_scene_to_file("res://scenes/Stage.tscn")

func load_game(saveName: String):
	SaveSystem.load_game(saveName)
	get_tree().change_scene_to_file("res://scenes/Stage.tscn")

func toggle_load_game():
	primaryMenuButtons.visible = !primaryMenuButtons.visible
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
	
func toggle_options():
	primaryMenuButtons.visible = !primaryMenuButtons.visible
	options.visible = !primaryMenuButtons.visible
	if options.visible:
		reset_settings()

func quit():
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
	
