extends Node

#save data
var savedDialogIndex = 0
var savedScene: String
var wormCollectableAmount: int = 0

#settings
var textVolume = 0.5
var sfxVolume = 0.5
var musicVolume = 0.5

var textSpeed = 0.04
var textAutoProgressSpeed = 0.5

var windowMode = 1
var resolutionIndex = 0

func load_data():
	savedDialogIndex = SaveSystem.data["saved_dialog_index"]
	savedScene = SaveSystem.data["saved_scene"]
