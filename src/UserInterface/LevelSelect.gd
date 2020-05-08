extends Control


func _ready() -> void:
	var levels = Global.levels
	for level in levels:
		if levels[level]:
			var row: String = "FirstRow" if int(level) < 6 else "SecondRow"
			var button: Button = get_node("LevelButtons/" + row + "/L" + level)
			button.disabled = false
