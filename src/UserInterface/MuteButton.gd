extends Button

func _on_button_up() -> void:
	if Data.muted:
		Data.muted = false
		self.text = "Sound off"
	else:
		Data.muted = true
		self.text = "Sound on"
