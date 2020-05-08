extends Node

const CONFIG_PATH = "user://config.cfg"

signal score_updated

onready var music_player: AudioStreamPlayer = $AudioStreamPlayer

# config
var _config: Dictionary = {
		"version": {
			"version": "1.0.1"
		},
		"sound": {
			"muted":false
		},
		"levels": {
			"01": true,
			"02": false,
			"03": false,
			"04": false,
			"05": false,
			"06": false,
			"07": false,
			"08": false,
			"09": false,
			"10": false,
		},
		"score": {
			"highest" : 0
		}
	}
var _config_file = create_config()

var score: = 0 setget set_score
var muted: bool = false setget , get_muted
var levels: Dictionary setget , get_levels
var highest_score: = 0 setget set_highest_score, get_highest_score


func _ready() -> void:
	load_config()
	highest_score = _config["score"]["highest"]
	muted = _config["sound"]["muted"]
	if !muted:
		music_player.play()


func reset_score() -> void:
	score = 0


func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")

	
func set_highest_score(score: int) -> void:
	highest_score = score
	_config["score"]["highest"] = score
	save_config()
	
	
func get_highest_score() -> int:
	return highest_score
	

func toggle_muted() -> void:
	muted = !muted
	if muted == false:
		music_player.play()
	else:
		music_player.stop()
	_config["sound"]["muted"] = muted
	save_config()
	

func get_muted() -> bool:
	return muted


func create_config() -> ConfigFile:
	var config_file = ConfigFile.new()
	for section in _config.keys():
		for key in _config[section]:
			config_file.set_value(section, key, _config[section][key])
	return config_file


func save_config() -> void:
	create_config().save(CONFIG_PATH)


func load_config() -> void:
	var error = _config_file.load(CONFIG_PATH)
	if error != OK:
		save_config()
		return
	for section in _config.keys():
		for key in _config[section]:
			_config[section][key] = _config_file.get_value(section, key, null)


func unlock_level(level: String) -> void:
	if _config["levels"][level] == false:
		_config["levels"][level] = true
		save_config()


func get_levels() -> Dictionary:
	return _config["levels"]
