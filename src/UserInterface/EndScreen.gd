extends Control

onready var score_label: Label = $ColorRect/ScoreLabel

func _ready() -> void:
	score_label.text = "Your score: %s" % Data.score
