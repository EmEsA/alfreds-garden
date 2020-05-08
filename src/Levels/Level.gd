extends Node2D

func _ready() -> void:
	var level_name = self.name
	var level_number = level_name.substr(len(level_name)-2)
	Global.unlock_level(level_number)
