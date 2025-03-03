extends Node

@onready var coin_sound = preload("res://assets/sounds/coin sound.wav")  # Change to your sound file

func play_coin_sound():
	var audio = AudioStreamPlayer.new()
	add_child(audio)
	audio.stream = coin_sound
	audio.play()
	await audio.finished
	audio.queue_free()
