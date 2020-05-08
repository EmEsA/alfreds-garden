extends Button

onready var starting_score: = Global.score


func _on_button_up() -> void:
	Global.score = starting_score
	get_tree().paused = false
	get_tree().reload_current_scene()
