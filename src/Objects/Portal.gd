extends Area2D

class_name Portal

export var is_fake: bool = false
export var fake_teleport_destination: Vector2
signal fake_teleport(destination)

onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var sprite: AnimatedSprite = $AnimatedSprite
onready var teleport_sound: AudioStreamPlayer = $TeleportSound
onready var black_overlay: ColorRect = $CanvasLayer/ColorRect


func _ready() -> void:
	sprite.play()
	if !is_fake:
		anim_player.play("LevelStart")
		yield(anim_player, "animation_finished")
		anim_player.play("Spinning")
	else:
		black_overlay.visible = false
		anim_player.play_backwards("Spinning")

export var next_scene: PackedScene


func _on_shape_entered(area_id: int, area: Area2D, area_shape: int, self_shape: int) -> void:
	if area.name == "PortalDetector":
		teleport()


func teleport() -> void:
	if !Global.muted:
		teleport_sound.play()
	if !is_fake:
		anim_player.play("LevelTransition")
		yield(anim_player, "animation_finished")
		if !Global.muted:
			yield(teleport_sound,"finished")
		get_tree().change_scene_to(next_scene)
	else:
		emit_signal("fake_teleport", fake_teleport_destination)
