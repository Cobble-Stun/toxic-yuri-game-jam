extends CanvasLayer

@onready var textSound = $"Text Sound"
@onready var musicPlayer = $"Music Player"
@onready var ambientPlayer = $"Ambient Player"
@onready var soundPlayer = $"Sound Player"

@onready var spritePrefab = preload("res://prefabs/sprite.tscn")
@onready var choiceMenuButton = preload("res://prefabs/choice_button.tscn")

@onready var controlNode = $Control
@onready var background = $Control/Background
@onready var choiceMenu = $"Choice Menu"
@onready var dialogueBox = $"Control/Dialogue Box"
@onready var nameText = $"Control/Dialogue Box/PanelContainer2/Name Text"
@onready var dialogueText = $"Control/Dialogue Box/PanelContainer/Dialogue Text"
@onready var textSpeedTimer = $"Text Speed Timer"
@onready var textAutoProgressTimer = $"Text Auto Progress Timer"
var dialog: Array = []
var stateHistory: Array[Dictionary] = []
var is_rolling_back = false
var dialogIndex = 0
var currentScript
var preventToggleDialogueBox = false
var gameDialogueBoxHide = false
var textRunning = false
var preventTextProgress = false

func _ready() -> void:
	textSpeedTimer.wait_time = Globals.textSpeed
	textAutoProgressTimer.wait_time = Globals.textAutoProgressSpeed
	dialogIndex = Globals.savedDialogIndex
	currentScript = Globals.savedScene
	dialog = prepare_script(Globals.savedScene)
	read_current_script_line()
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ToggleDialogueBox") and preventToggleDialogueBox == false:
		toggle_dialogue_box(false)
	if !dialogueBox.visible and gameDialogueBoxHide == false:
		return
	if preventTextProgress == true:
		return
	if Input.is_action_just_pressed("NextDialogue"):
		if textRunning:
			complete_text_instantly()
		elif dialogIndex < dialog.size()-1:
			capture_scene_state()
			dialogIndex += 1
			
			read_current_script_line()
	if Input.is_action_just_pressed("PreviousDialogue"):
		scene_rollback()
	
func prepare_script(jsonFile):
	jsonFile = "res://scenes/scene scripts/" + jsonFile + ".json"
	var file = FileAccess.open(jsonFile, FileAccess.READ)
	var content = file.get_as_text()
	var jsonContent = JSON.parse_string(content)
	return jsonContent
	
func complete_text_instantly():
	textRunning = false
	dialogueText.text = dialog[dialogIndex]["text"]
	
func capture_scene_state():
	var snapshot = {
		"scene": currentScript,
		"index": dialogIndex,
		"music": musicPlayer.stream.resource_path if musicPlayer.stream else null,
		"ambient": ambientPlayer.stream.resource_path if ambientPlayer.stream else null,
		"background": background.texture.resource_path if background.texture else null,
		"bg_scale": background.scale,
		"speaker": nameText.text,
		"text": dialogueText.text,
		"sprites": [] 
	}
	
	for child in controlNode.get_children():
		if child.get_groups().size() > 0:
			snapshot["sprites"].append({
				"group": child.get_groups()[0],
				"texture": child.texture.resource_path if child.texture else null,
				"pos": child.position,
				"scale": child.scale
			})
	
	stateHistory.append(snapshot)
	
func scene_rollback():
	if stateHistory.size() < 1:
		return
		
	textRunning = false
	
	var last_state = stateHistory.pop_back()
	
	if last_state["scene"] != currentScript:
		currentScript = last_state["scene"]
		dialog = prepare_script(currentScript)
	
	dialogIndex = last_state["index"]
	
	nameText.text = last_state["speaker"]
	dialogueText.text = last_state["text"]
	
	
	for node in get_tree().get_nodes_in_group("sprites"):
		node.queue_free()
	
	background.texture = null
	
	if last_state["background"]:
		background.texture = load(last_state["background"])
		background.scale = last_state["bg_scale"]
		
	if last_state["music"] and (musicPlayer.stream == null or musicPlayer.stream.resource_path != last_state["music"]):
		musicPlayer.stream = load(last_state["music"])
		musicPlayer.play()
		
	for node in get_tree().get_nodes_in_group("sprites"):
		node.queue_free()
		
	for s in last_state["sprites"]:
		var newSprite = spritePrefab.instantiate()
		controlNode.add_child(newSprite)
		newSprite.texture = load(s["texture"])
		newSprite.position = s["pos"]
		newSprite.scale = s["scale"]
		newSprite.add_to_group(s["group"])
		newSprite.add_to_group("sprites")
	
func read_current_script_line():
	var line = dialog[dialogIndex]
	
	#choices
	if line.has("choices"):
		display_choices(line["choices"])
	
	#audio
	if line.has("music"):
		play_audio("res://audio/music/", line["music"], musicPlayer)
		
	if line.has("ambient"):
		play_audio("res://audio/ambient/", line["ambient"], ambientPlayer)
	
	if line.has("sound"):
		play_audio("res://audio/sounds/", line["sound"], soundPlayer)
	
	#sprites
	if line.has("sprite"):
		sprite_channel(line["sprite"])
	if line.has("sprite2"):
		sprite_channel(line["sprite2"])
	if line.has("sprite3"):
		sprite_channel(line["sprite3"])
	if line.has("sprite4"):
		sprite_channel(line["sprite4"])
	
	if line.has("delete_sprite"):
		delete_sprite(line["delete_sprite"])
		
	if line.has("background"):
		var lineInfo = line["background"].split(":")
		var spriteImage
		for image in DirAccess.open("res://images/backgrounds/").get_files():
			if image == lineInfo[0] + ".png":
				spriteImage = load("res://images/backgrounds/" + image)
		change_background(spriteImage, float(lineInfo[1]))
	
	#jumping
	if line.has("goto"):
		dialogIndex = get_anchor(line["goto"])
		read_current_script_line()
		return
	
	if line.has("anchor"):
		dialogIndex += 1
		read_current_script_line()
		return
		
	if line.has("next_scene"):
		currentScript = line["next_scene"]
		dialog = prepare_script(line["next_scene"])
		dialogIndex = 0
		read_current_script_line()
		
	#text
	if line.has("speaker"):
		assign_speaker_name(line["speaker"])
	else:
		assign_speaker_name("")
		
	if line.has("text"):
		assign_text(line["text"])
		
	#event
	if line.has("event"):
		match line["event"]:
			"hide text":
				dialogueBox.visible = false
				gameDialogueBoxHide = true
			"unhide text":
				dialogueBox.visible = true
				gameDialogueBoxHide = false
	Globals.savedDialogIndex = dialogIndex
	Globals.savedScene = currentScript
		

func toggle_dialogue_box(removeText : bool):
	dialogueBox.visible = !dialogueBox.visible
	if removeText == true:
		nameText.text = ""
		dialogueText.text = ""
	
#choices
func display_choices(choices: Array):
	toggle_dialogue_box(true)
	preventToggleDialogueBox = true
	for child in choiceMenu.get_children():
		child.queue_free()
	for choice in choices:
		var button = choiceMenuButton.instantiate()
		button.get_child(0).text = choice["text"]
		button.pressed.connect(choice_selected.bind(choice["goto"]))
		choiceMenu.add_child(button)
	choiceMenu.show()

func choice_selected(anchor: String):
	choiceMenu.hide()
	toggle_dialogue_box(false)
	preventToggleDialogueBox = false
	dialogIndex = get_anchor(anchor)
	read_current_script_line()
	
#audio
func play_audio(dir: String, jsonKey: String, audioPLayer: AudioStreamPlayer):
	var sound
	for track in DirAccess.open(dir).get_files():
		if track == jsonKey + ".ogg":
			sound = load(dir + track)
	if sound == null:
		change_audio_track(null, audioPLayer)
		return
	change_audio_track(sound, audioPLayer)
	
func change_audio_track(audio : AudioStream, track : AudioStreamPlayer):
	track.stream = audio
	track.play()
	
#sprites
func sprite_channel(spriteName):
	var spriteImage
	var imageInfo = spriteName.split(":")
	for image in DirAccess.open("res://images/foreground sprites/").get_files():
		if image == imageInfo[0] + ".png" or image == imageInfo[0] + ".jpg":
			spriteImage = load("res://images/foreground sprites/" + image)
	change_sprite(spriteImage, imageInfo[1], int(imageInfo[2]), int(imageInfo[3]), float(imageInfo[4]))
	
func change_sprite(sprite: Texture2D, spriteGroup: String, locationX : int = 0, locationY : int = 0, zoom: float = 1.0):
	var spriteHusk = get_tree().get_first_node_in_group(spriteGroup)
	if spriteHusk != null:
		spriteHusk.texture = sprite
		spriteHusk.position.x = locationX
		spriteHusk.position.y = locationY
		spriteHusk.scale = spriteHusk.scale * zoom
	else:
		var newSpriteHusk = spritePrefab.instantiate()
		get_child(0).add_child(newSpriteHusk)
		newSpriteHusk.texture = sprite
		newSpriteHusk.pivot_offset = newSpriteHusk.size/2
		newSpriteHusk.position.x = locationX
		newSpriteHusk.position.y = locationY
		newSpriteHusk.scale = newSpriteHusk.scale * zoom
		newSpriteHusk.add_to_group(spriteGroup)
		newSpriteHusk.add_to_group("sprites")
	
func delete_sprite(spriteGroup: String):
	if get_tree().get_nodes_in_group(spriteGroup).size() > 0:
		get_tree().call_group(spriteGroup, "queue_free")
		
func change_background(bg : Texture2D, zoom: float = 1.0):
	background.texture = bg
	background.scale = Vector2(1.0,1.0) * zoom
	
#text
func assign_speaker_name(lineInfo: String):
	#char name
	if lineInfo == "":
		nameText.text = ""
		return
	
	if lineInfo != null:
		nameText.text = lineInfo
	else:
		nameText.text = "???"
	
func assign_text(lineInfo):
	textRunning = true
	#dialogue
	var lineChars = lineInfo.split()
	var ignoreChars = false
	dialogueText.text = ""
	for c in lineChars:
		if textRunning == false:
			return
		if c == "[":
			ignoreChars = true
		if c == "]":
			ignoreChars = false
			
		dialogueText.text += c
		if ignoreChars == false:
			textSound.typing_sounds()
			textSpeedTimer.start()
			await textSpeedTimer.timeout
			
	textRunning = false
	
#effects
func fade():
	pass
	
func sprite_bounce(spriteGroup: String, time : float, amount : float = 50.0):
	var tween = create_tween()
	var sprite = get_tree().get_first_node_in_group(spriteGroup)
	tween.tween_property(sprite, "position", Vector2(0,-amount)+sprite.position, time/2.0)
	tween.tween_property(sprite, "position", Vector2(0,0)+sprite.position, time/2.0)

func sprite_shake(spriteGroup: String, time : float, amount : float = 50.0):
	var tween = create_tween()
	var sprite = get_tree().get_first_node_in_group(spriteGroup)
	tween.tween_property(sprite, "position", Vector2(amount,0)+sprite.position, time/4.0)
	tween.tween_property(sprite, "position", Vector2(-amount,0)+sprite.position, time/2.0)
	tween.tween_property(sprite, "position", Vector2(0,0)+sprite.position, time/4.0)
	
func get_anchor(anchor: String):
	for i in range(dialog.size()):
		if dialog[i].has("anchor") and dialog[i]["anchor"] == anchor:
			return i
	print("errrmmm anchor error: " + anchor)
	return null
