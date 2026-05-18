extends Node

@export var nextDialogueSound : AudioStream
@export var textSounds : Array[AudioStream]

func next_dialogue():
	play_sound(nextDialogueSound, true)
	
func typing_sounds():
	play_sound(textSounds, false)

func play_sound(audio, singleSound):
	if Globals.textVolume > 0:
		var textSoundPlayer = AudioStreamPlayer.new()
		self.add_child(textSoundPlayer)
		textSoundPlayer.set_bus("Text")
		if singleSound:
			textSoundPlayer.stream = audio
		else: 
			textSoundPlayer.stream = audio.pick_random()
		textSoundPlayer.play()
		await textSoundPlayer.finished
		textSoundPlayer.queue_free()
