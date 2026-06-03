extends HBoxContainer

@export var scenePlayer: Node
@export var history: Node
#@onready var labelScene = load()

func _ready() -> void:
	for button in get_children():
		button.connect("mouse_entered", _on_mouse_entered)
		button.connect("mouse_exited", _on_mouse_exited)

func auto_toggle():
	scenePlayer.auto = !scenePlayer.auto
	
func skip_toggle():
	scenePlayer.skipping = !scenePlayer.skipping

func save_game() -> void:
	var dateTime = Time.get_datetime_dict_from_system()
	var fileName = str(dateTime.year) + "-" + "%02d" % dateTime.month + "-" + "%02d" % dateTime.day + " " + "%02d" % dateTime.hour + "." + "%02d" % dateTime.minute
	SaveSystem.save_game(fileName)
	
func load_game():
	var files = DirAccess.get_files_at("user://")
	var mostRecentSave: String
	for file_name in files:
		if mostRecentSave.is_empty():
			if file_name.get_extension() == "json":
				mostRecentSave = file_name
				continue
		if file_name.get_extension() == "json":
			var currentTimestamp = Time.get_datetime_string_from_unix_time(FileAccess.get_modified_time("user://" + file_name))
			var recentTimestamp = Time.get_datetime_string_from_unix_time(FileAccess.get_modified_time("user://" + mostRecentSave))
			if (currentTimestamp > recentTimestamp):
				mostRecentSave = file_name
			
	SaveSystem.load_game(mostRecentSave.get_basename())
	get_tree().change_scene_to_file("res://scenes/Stage.tscn")
	
func show_history():
	history.visible = !history.visible
	if history.visible:
		visible = false
		scenePlayer.preventTextProgress = true
		var historyVbox = history.get_node("ScrollContainer").get_node("VBoxContainer")
		
		for line in historyVbox.get_children():
			line.queue_free()
		for line in scenePlayer.stateHistory:
			var lineLabel = Label.new()
			var lineChars = line["text"].split()
			var rawLine = ""
			var ignoreChars = false
			for c in lineChars:
				if c == "[":
					ignoreChars = true
				if c == "]":
					ignoreChars = false
					continue
					
				if ignoreChars == true:
					continue
				rawLine += c
			lineLabel.text = rawLine
			historyVbox.add_child(lineLabel)
	if !history.visible:
		visible = true
		scenePlayer.preventTextProgress = false

func _on_mouse_entered() -> void:
	scenePlayer.preventTextProgress = true

func _on_mouse_exited() -> void:
	scenePlayer.preventTextProgress = false
