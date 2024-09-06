extends CharacterBody2D

@onready var main = get_tree().get_current_scene()
@export var speed: float = 200
@onready var projectile = load("res://scenes/bullet.tscn")
@onready var timer: Timer = $Timer
@onready var death_timer: Timer = $deathTimer

var lifes = 3

var canShoot: bool = true
var direction = Vector2.ZERO
var min_x: float
var max_x: float
var min_y: float
var max_y: float
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and canShoot == true:
		shoot()
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("move_right"):
		direction.x = 1
	elif Input.is_action_just_pressed("move_left"):
		direction.x = -1
	if Input.is_action_just_released("move_right") and direction.x == 1:
		direction.x = 0
	elif Input.is_action_just_released("move_left") and direction.x == -1:
		direction.x = 0
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()
	global_position.x = clamp(global_position.x, min_x, max_x)
	global_position.y = clamp(global_position.y, min_y, max_y)
func _ready() -> void:
	var parent_size = get_parent().get_rect().size
	min_x = 0
	max_x = parent_size.x
	min_y = 0
	max_y = parent_size.y
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

func _on_area_2d_body_entered(body: Node2D) -> void:
	lifes = lifes - 1
	death_timer.start()
	if lifes == 0:
		print("game over")
	else:
		get_tree().paused = true


func _on_death_timer_timeout() -> void:
	get_tree().paused = false
