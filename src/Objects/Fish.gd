extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
onready var munch: AudioStreamPlayer = $MunchSound
onready var colision_shape: CollisionShape2D = $CollisionShape2D

export var score: = 100

var has_been_picked: = false

func _on_body_entered(body: Node) -> void:
	if !has_been_picked:
		picked()

func picked() -> void:
	has_been_picked = true
	Data.score += score
	if !Data.muted:
		munch.play()
	anim_player.play("Cought")
	yield(anim_player,"animation_finished")
	queue_free()
