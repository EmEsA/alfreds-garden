extends Node

onready var viewport = get_viewport()

var _max_ratio: float = 16.0/8.0


func _ready() -> void:
	viewport.connect("size_changed", self, "window_resize")


func window_resize() -> void:
	var current_size = OS.get_window_size()	
	var ratio = current_size.x / current_size.y
	if ratio > _max_ratio:	
		var new_size = Vector2(current_size.y * _max_ratio, current_size.y)
		print(current_size.y * _max_ratio)
		print(new_size)
		OS.set_window_size(new_size)

	
