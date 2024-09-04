extends CharacterBody2D

#this main variable is used to get the main node where the game is taking place. replace "testingRoom" with the main node of the scene
@onready var main = get_tree().get_root().get_node("testingRoom")

@export var speed: float = 200
@onready var projectile = load("res://scenes/bullet.tscn")

@onready var timer: Timer = $Timer

var canShoot: bool = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and canShoot == true:
		shoot()
func _physics_process(delta: float) -> void:
	var input_Direction = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),Input.get_action_strength("move_down") -Input.get_action_strength("move_up")).normalized()

	
	velocity = input_Direction * speed
	
	move_and_slide()
func shoot():
	canShoot = false
	timer.start()
	var instance = projectile.instantiate()
	instance.direction = rotation
	instance.spawnPos = Vector2(global_position.x, global_position.y - 50)
	instance.spawnRot = rotation
	main.add_child.call_deferred(instance)


func _on_timer_timeout() -> void:
	canShoot = true
