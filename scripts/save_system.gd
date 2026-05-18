extends Node

const path = "user://"
var data: Dictionary
var access: FileAccess

func new_game() -> void:
	data = {
		"saved_dialog_index" : 0,
		"saved_scene" : "test",
	}
	
func save_game(fileName):
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png(path + fileName + "Thumbnail")
	access = FileAccess.open(path + fileName, FileAccess.WRITE)
	access.store_string(JSON.stringify(data))
	access.close()
	
func load_game(fileName):
	if FileAccess.file_exists(path + fileName):
		access = FileAccess.open(path + fileName, FileAccess.READ)
		data = JSON.parse_string(access.get_as_text())
		access.close()
		
func read_all_saves() -> Dictionary:
	var dict
	var files = DirAccess.get_files_at(path)
	for file_name in files:
		var full_path = path.path_join(file_name + "Thumbnail")
		var file = FileAccess.open(full_path, FileAccess.READ)
		if file:
			dict[file_name] = file
		else:
			dict[file_name] = load("res://gui/Placeholder Save Thumbnail.png")
	return dict
