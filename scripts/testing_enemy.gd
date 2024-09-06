extends Sprite2D

@onready var main = get_tree().get_current_scene()

@onready var projectile = load("res://scenes/enemy_bullet.tscn")

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.start()

func shoot():
	timer.start()
	var instance = projectile.instantiate()
	instance.direction = rotation
	instance.spawnPos = Vector2(global_position.x, global_position.y)
	instance.spawnRot = rotation
	main.add_child.call_deferred(instance)


func _on_timer_timeout() -> void:
	shoot()
	timer.start()
