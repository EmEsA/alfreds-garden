extends Control

onready var highest_score_label: Label = $ColorRect/HighestScore


func _ready() -> void:
	if Global.highest_score > 0:
		highest_score_label.visible = true
		highest_score_label.text = "Highest score: %s" % Global.highest_score
