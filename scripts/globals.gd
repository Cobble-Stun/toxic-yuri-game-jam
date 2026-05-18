extends Node

#save data
var savedDialogIndex = 0
var savedScene: String

#settings
var textVolume = 0
var sfxVolume = 0
var musicVolume = 0

var textSpeed = 0.05
var textAutoProgressSpeed = 3.0

func load_data():
	savedDialogIndex = SaveSystem.data["saved_Dialog_index"]
	savedScene = SaveSystem.data["saved_scene"]
