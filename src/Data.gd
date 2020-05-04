extends Node

signal score_updated
signal player_died

var score: = 0 setget set_score
var muted: bool = false

func reset() -> void:
	score = 0

func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")
