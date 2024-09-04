extends CharacterBody2D

@export var speed = 100
var direction: float
var spawnPos: Vector2
var spawnRot: float


func _ready() -> void:
	global_position = spawnPos

func _physics_process(delta: float) -> void:
	velocity = Vector2(0, -speed).rotated(direction)
	move_and_slide()
