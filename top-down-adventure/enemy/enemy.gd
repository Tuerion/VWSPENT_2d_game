extends CharacterBody2D

@export var speed: float = 50.0

var player: CharacterBody2D
var bullet_scene = preload("res://bullet/bullet.tscn")

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().call_deferred("reload_current_scene")

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet.direction = global_position.direction_to(player.global_position)
	
	get_tree().current_scene.add_child(bullet)
	


func _on_shoot_timer_timeout() -> void:
	shoot()
