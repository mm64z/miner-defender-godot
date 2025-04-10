extends CharacterBody2D

@onready var gun_tip: Node2D = $Gun/GunTip
@onready var gun: Sprite2D = $Gun
@onready var player: CharacterBody2D = $"."

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const SHOOT_COOLDOWN = 0.3 # seconds
var shootTimer = 0

const BULLET = preload("res://scenes/bullet.tscn")
func shoot_bullet(delta: float):
	if shootTimer <= 0:
		shootTimer = SHOOT_COOLDOWN
		var bullet = BULLET.instantiate()
		bullet.position = gun_tip.global_position 
		bullet.rotation = (get_global_mouse_position() - gun_tip.global_position).angle()
		get_tree().current_scene.add_child(bullet)
	else:
		shootTimer -= delta

func _physics_process(delta: float) -> void:
	
	# rotate towards mouse cursor
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).angle()
	rotation = direction

	# Get the input direction and handle the movement/deceleration.
	var directionX := Input.get_axis("left", "right")
	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var directionY := Input.get_axis("up", "down")
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_pressed("shoot"):
		shoot_bullet(delta)

	move_and_slide()
