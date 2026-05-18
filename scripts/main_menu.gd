extends CanvasLayer

@onready var loadSlotScene = preload("res://prefabs/UI/load_slot.tscn")
@export var bgs: Array[Texture2D]
@onready var background = $Control/Background
@onready var primaryMenuButtons = $"Control/Primary Menu Buttons"
@onready var options = $Control/Options
@onready var loadGame = $"Control/Load Game"
@onready var loadSlotParent = $Control/LoadGame/VBoxContainer

@onready var textVolumeValue = $"Control/Options/Text Volume/Label"
@onready var sfxVolumeValue = $"Control/Options/SFX Volume/Label"
@onready var musicVolumeValue = $"Control/Options/Music Volume/Label"
@onready var textSpeedValue = $"Control/Options/Text Speed/Label"
@onready var autoProgressValue = $"Control/Options/Auto Progress Speed/Label"

func _ready() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Text"), Globals.textVolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), Globals.musicVolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), Globals.sfxVolume)
	textVolumeValue.text = str(Globals.textVolume+72)
	sfxVolumeValue.text = str(Globals.sfxVolume+72)
	musicVolumeValue.text = str(Globals.musicVolume+72)
	textSpeedValue.text = str(Globals.textSpeed)
	autoProgressValue.text = str(Globals.textAutoProgressSpeed)
	#if Globals.changeMainMenuBackground == true:
		#background.texture = bgs[1]
	#else:
		#background.texture = bgs[0]
	#temp below
	background.texture = bgs[0]
	
	
	#loadSlotParent.add_child()
		
func start_new_game():
	SaveSystem.new_game()
	Globals.load_data()
	get_tree().change_scene_to_file(Globals.savedScene)

func load_game():
	#SaveSystem.load_game()
	Globals.load_data()
	get_tree().change_scene_to_file(Globals.savedScene)

func toggle_load_game():
	primaryMenuButtons.visible = !primaryMenuButtons.visible
	loadGame.visible = !primaryMenuButtons.visible
	
func toggle_options():
	primaryMenuButtons.visible = !primaryMenuButtons.visible
	options.visible = !primaryMenuButtons.visible

func quit():
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
	
	
