extends Node

#save data
var savedDialogIndex = 0
var savedScene: String

#settings
var textVolume = 0.5
var sfxVolume = 0.5
var musicVolume = 0.5

var textSpeed = 0.04
var textAutoProgressSpeed = 3.0

func load_data():
	savedDialogIndex = SaveSystem.data["saved_dialog_index"]
	savedScene = SaveSystem.data["saved_scene"]
