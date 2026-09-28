extends CharacterBody2D


const SPEED = 300.0
const DASH_SPEED = 900.0
const DASH_TIME = 0.15

var last_direction := "down"
var is_dashing := false
var dash_timer := 0.0

signal coins_changed(total: int)
var amount: int


func _physics_process(delta: float) -> void:
	handle_dash(delta)
	
	if not is_dashing:
		handle_movement()
	
	move_and_slide()


func handle_dash(delta: float) -> void:
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false
		return
	
	if Input.is_action_just_pressed("dash"):
		is_dashing = true
		dash_timer = DASH_TIME
		
		match last_direction:
			"down":
				velocity = Vector2.DOWN * DASH_SPEED
			"up":
				velocity = Vector2.UP * DASH_SPEED
			"left":
				velocity = Vector2.LEFT * DASH_SPEED
			"right":
				velocity = Vector2.RIGHT * DASH_SPEED


func handle_movement() -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	
	if Input.is_action_pressed("move_down"):
		$AnimatedSprite2D.play("walk_down")
		last_direction = "down"
	elif Input.is_action_pressed("move_up"):
		$AnimatedSprite2D.play("walk_up")
		last_direction = "up"
	elif Input.is_action_pressed("move_right"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("walk_side")
		last_direction = "right"
	elif Input.is_action_pressed("move_left"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("walk_side")
		last_direction = "left"
	else:
		if last_direction == "down":
			$AnimatedSprite2D.play("idle_down")
		elif last_direction == "up":
			$AnimatedSprite2D.play("idle_up")
		elif last_direction == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("idle_side")
		elif last_direction == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("idle_side")


func add_coin(value: int) -> void:
	amount += value
	coins_changed.emit(amount)
