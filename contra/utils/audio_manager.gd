extends Node

@onready var bgm_streamer := $BackgroundMusic


func play_background_music(stream: AudioStream, bus: String = "BGM") -> void:
	bgm_streamer.bus = bus

	if bgm_streamer.stream == stream:
		return

	bgm_streamer.stream = stream
	bgm_streamer.play()


func play_sound_effect(stream: AudioStream, bus: String = "FX") -> void:
	var new_sfx := AudioStreamPlayer.new()
	new_sfx.stream = stream
	new_sfx.bus = bus
	new_sfx.finished.connect(destroy_stream_player.bind(new_sfx))
	add_child(new_sfx)
	new_sfx.play()


func destroy_stream_player(stream_player: AudioStreamPlayer) -> void:
	stream_player.queue_free()


func set_volume(bus: String, value: float):
	var bus_index = AudioServer.get_bus_index(bus)
	
	if value <= 0.001:
		AudioServer.set_bus_mute(bus_index, true)
		return
	else:
		AudioServer.set_bus_mute(bus_index, false)

	var target_db = linear_to_db(value)
	var current_volume_db = AudioServer.get_bus_volume_db(bus_index)

	var tween = create_tween()
	tween.tween_method(
		func(db):
			AudioServer.set_bus_volume_db(bus_index, db),
		current_volume_db,
		target_db,
		0.1
	)
