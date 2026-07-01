extends Node2D

@export var bgm: AudioStream

func _ready() -> void:
	AudioManager.play_background_music(bgm)
