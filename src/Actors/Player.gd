extends Actor

onready var player_animations: AnimationPlayer = $PlayerAnimations
onready var camera_animations: AnimationPlayer = $CameraAnimations
onready var camera: Camera2D = $Camera2D
onready var sprite: AnimatedSprite = $ AnimatedSprite
onready var collision_shape: CollisionShape2D = $CollisionShape2D
onready var trampoline_detector: Area2D = $TrampolineDetector
onready var boing: AudioStreamPlayer = $BoingSound

func _on_TrampolineDetector_area_shape_entered(area_id: int, area: Trampoline, area_shape: int, self_shape: int) -> void:
	if area != null:
		var trampoline_power =  area.power
		_velocity = calculate_bounce_velocity(_velocity, trampoline_power)
		if !Data.muted:
			boing.play()
		player_animations.play("Jump")

func _on_PortalDetector_area_shape_entered(area_id: int, area: Portal, area_shape: int, self_shape: int) -> void:
	if area != null:
		set_physics_process(false)
		player_animations.play("Teleport")
		emit_signal("teleport_entered")

func _physics_process(delta: float) -> void:
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	var x = Input.get_action_strength("move_right")	- Input.get_action_strength("move_left")	
	var y = 1	
	
	if x > 0:
		turn_left()
	elif x < 0:
		turn_right()
			
	if is_on_floor():
		#if camera.zoom.x > 1:
		#	camera_animations.play_backwards("Zoom")
		if _velocity.y >= 0:
			if x != 0:
				player_animations.play("Walk")
			else:
				player_animations.play("Idle")
			
		if Input.get_action_strength("jump") and is_on_floor():
			y = -1.0
			if !Data.muted:
				boing.play()
			player_animations.play("Jump")
	else:
		pass
		#player_animations.play("Jump")
		#if camera.zoom.x < 1.5:
		#	camera_animations.play("Zoom")
		
	
	return Vector2(x,y)
		

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2
	) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	#if is_jump_interrupted:
	#	new_velocity.y = 0.0
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	return new_velocity

func calculate_bounce_velocity(linear_velocity: Vector2, power: float) -> Vector2:
	var out: = linear_velocity
	out.y = -power
	return out

func turn_right() -> void:
	sprite.flip_h = true
	sprite.position.x = 48
	
func turn_left() -> void:
	sprite.flip_h = false
	sprite.position.x = 0
