extends CanvasLayer

@onready var loadSlotScene = preload("res://prefabs/UI/load_slot.tscn")
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
@onready var windowModeDropdown = $"Control/Options/Window Mode/OptionButton"
@onready var resolutionDropdown = $"Control/Options/Resolution/OptionButton"

var resolutions: Dictionary = {"3840x2160":Vector2i(3840,2160),
								"2560x1440":Vector2i(2560,1080),
								"1920x1080":Vector2i(1920,1080),
								"1366x768":Vector2i(1366,768),
								"1536x864":Vector2i(1536,864),
								"1280x720":Vector2i(1280,720),
								"1440x900":Vector2i(1440,900),
								"1600x900":Vector2i(1600,900),
								"1024x600":Vector2i(1024,600),
								"800x600": Vector2i(800,600)}

func _ready() -> void:
	SaveSystem.load_settings()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Text"), Globals.textVolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), Globals.musicVolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), Globals.sfxVolume)
	var Current_Resolution = get_window().get_size()
	var ID = 0
	
	for r in resolutions:
		resolutionDropdown.add_item(r, ID)
		
		if resolutions[r] == Current_Resolution:
			resolutionDropdown.select(ID)
		
		ID += 1
	get_window().set_size(resolutions[resolutionDropdown.get_item_text(Globals.resolutionIndex)])
	match Globals.windowMode:
		0:
			get_window().set_mode(Window.MODE_FULLSCREEN)
		1:
			get_window().set_mode(Window.MODE_WINDOWED)
	reset_settings()
		
func start_new_game():
	SaveSystem.load_scene("together")
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
	
func select_window_mode(index: int) -> void:
	Globals.windowMode = index
		
func select_resolution(index: int) -> void:
	Globals.resolutionIndex = index
	
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
	windowModeDropdown.selected = Globals.windowMode
	resolutionDropdown.selected = Globals.resolutionIndex
	
func save_changes():
	Globals.textVolume = float(textVolumeValue.text)/100
	Globals.musicVolume = float(musicVolumeValue.text)/100
	Globals.sfxVolume = float(sfxVolumeValue.text)/100
	Globals.textSpeed = float(textSpeedValue.text)
	Globals.textAutoProgressSpeed = float(autoProgressValue.text)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Text"), linear_to_db(Globals.textVolume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(Globals.musicVolume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), linear_to_db(Globals.sfxVolume))
	match Globals.windowMode:
		0:
			get_window().set_mode(Window.MODE_FULLSCREEN)
		1:
			get_window().set_mode(Window.MODE_WINDOWED)
	get_window().set_size(resolutions[resolutionDropdown.get_item_text(Globals.resolutionIndex)])
	SaveSystem.save_settings()
