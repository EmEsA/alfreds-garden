extends Button

func _ready() -> void:
	refresh_text()


func _on_button_up() -> void:
	Global.toggle_muted()
	refresh_text()


func refresh_text() -> void:
	if Global.muted:
		self.text = "Sound on"
	else:
		self.text = "Sound off"
