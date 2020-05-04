extends Actor

class_name Stork

func _ready() -> void:
	_velocity.x = -speed.x

func _physics_process(delta: float) -> void:
	if is_on_wall():
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		_velocity.x *= -1.0
	move_and_slide(_velocity, FLOOR_NORMAL)
