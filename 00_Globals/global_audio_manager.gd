extends Node


var music_audio_player_count : int = 2
var current_music_player : int = 0
var music_players: Array[AudioStreamPlayer] = []
var music_bus: String = "Music"

var music_fade_duration: float = 0.5

func _ready() -> void:
	for i in music_audio_player_count:
		var audioplayer = AudioStreamPlayer.new()
		add_child(audioplayer)
		audioplayer.bus = music_bus
		music_players.append( audioplayer )
		
func play_music( _audio : AudioStream  ) -> void:
	music_players[0].stream = _audio
	music_players[0].play(0)
