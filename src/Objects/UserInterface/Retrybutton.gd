extends Button

onready var starting_score: = Data.score

func _on_button_up() -> void:
	Data.score = starting_score
	get_tree().paused = false
	get_tree().reload_current_scene()
