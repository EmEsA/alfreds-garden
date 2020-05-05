extends Node

onready var music_player: AudioStreamPlayer = $AudioStreamPlayer

signal score_updated
signal player_died

var score: = 0 setget set_score
var muted: bool = false setget set_muted, get_muted

func _ready() -> void:
	$AudioStreamPlayer.play()

func reset() -> void:
	score = 0

func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")

func set_muted(value: bool) -> void:
	muted = value
	if muted == false:
		music_player.play()
	else:
		music_player.stop()
	
func get_muted() -> bool:
	return muted
