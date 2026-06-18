extends Node

const path = "user://"
var data: Dictionary
var access: FileAccess

func load_scene(scene: String) -> void:
	data = {
		"saved_dialog_index" : 0,
		"saved_scene" : scene,
	}
	
func save_game(fileName: String):
	var dateTime = Time.get_datetime_dict_from_system()
	get_viewport().get_texture().get_image().save_png(path + fileName + "Thumbnail.png")
	data["date_and_time"] = str(dateTime.year) + "-" + "%02d" % dateTime.month + "-" + "%02d" % dateTime.day + " " + "%02d" % dateTime.hour + ":" + "%02d" % dateTime.minute
	data["saved_dialog_index"] = Globals.savedDialogIndex
	data["saved_scene"] = Globals.savedScene
	
	access = FileAccess.open(path + fileName + ".json", FileAccess.WRITE)
	access.store_string(JSON.stringify(data))
	access.close()
	
func save_settings():
	var settings = {}
	settings["textVolume"] = Globals.textVolume
	settings["sfxVolume"] = Globals.sfxVolume
	settings["musicVolume"] = Globals.musicVolume
	settings["textSpeed"] = Globals.textSpeed
	settings["textAutoProgressSpeed"] = Globals.textAutoProgressSpeed
	
	access = FileAccess.open(path + "settings.json", FileAccess.WRITE)
	access.store_string(JSON.stringify(settings))
	access.close()

func load_settings():
	if FileAccess.file_exists(path + "settings.json"):
		access = FileAccess.open(path + "settings.json", FileAccess.READ)
		var settings = JSON.parse_string(access.get_as_text())
		Globals.textVolume = settings["textVolume"]
		Globals.sfxVolume = settings["sfxVolume"]
		Globals.musicVolume = settings["musicVolume"]
		Globals.textSpeed = settings["textSpeed"]
		Globals.textAutoProgressSpeed = settings["textAutoProgressSpeed"]
	else:
		return
	
func load_game(fileName: String):
	if FileAccess.file_exists(path + fileName + ".json"):
		access = FileAccess.open(path + fileName + ".json", FileAccess.READ)
		data = JSON.parse_string(access.get_as_text())
		Globals.load_data()
		access.close()
		
func read_save_data() -> Dictionary:
	var saves = {}
	var saveData = {}
	var files = DirAccess.get_files_at(path)
	for file_name in files:
		var openedFile = FileAccess.open(path + file_name, FileAccess.READ)
		if openedFile != null and file_name.get_extension() == "json":
			saveData = JSON.parse_string(openedFile.get_as_text())
			if file_name.get_basename() == "settings":
				continue
			saves[file_name.get_basename()] = saveData
	return saves
	
func read_save_image(imgName: String) -> Texture2D:
	var openedFile = FileAccess.open(path + imgName + "Thumbnail.png", FileAccess.READ)
	if openedFile == null:
		return null
	
	var buffer := openedFile.get_buffer(openedFile.get_length())
	var img := Image.new()
	var err := img.load_png_from_buffer(buffer)
	if err != OK:
		return null

	return ImageTexture.create_from_image(img)
	
