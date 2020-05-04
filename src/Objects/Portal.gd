tool
extends Area2D

class_name Portal

onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var sprite: AnimatedSprite = $AnimatedSprite
onready var teleport_sound: AudioStreamPlayer = $TeleportSound

func _ready() -> void:
	anim_player.play("LevelStart")
	yield(anim_player, "animation_finished")
	anim_player.play("Spinning")
	sprite.play()
	

export var next_scene: PackedScene

func _on_shape_entered(area_id: int, area: Area2D, area_shape: int, self_shape: int) -> void:
	if area.name == "PortalDetector":
		teleport()

func _get_configuration_warning() -> String:
	return "The next scene property is required" if not next_scene else ""

func teleport() -> void:
	anim_player.play("LevelTransition")
	if !Data.muted:
		teleport_sound.play()
	yield(anim_player, "animation_finished")
	if !Data.muted:
		yield(teleport_sound,"finished")
	get_tree().change_scene_to(next_scene)
