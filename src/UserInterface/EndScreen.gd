extends Control

onready var score_label: Label = $ColorRect/ScoreLabel

func _ready() -> void:
	var score = Global.score
	if score > Global.highest_score:
		Global.highest_score = score
		score_label.text = "New highest score! %s" % Global.score
	else:
		score_label.text = "Your score: %s" % Global.score
