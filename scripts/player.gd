extends CharacterBody2D

@onready var gun_tip: Node2D = $Gun/GunTip
@onready var gun: Sprite2D = $Gun
@onready var player: CharacterBody2D = $"."
@onready var game_manager: Node = %GameManager
@onready var build_range: Area2D = $"Build Range"

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var shootTimer = 0

var active_weapon = {}

const BULLET = preload("res://scenes/bullet.tscn")
const MINER = preload("res://scenes/miner.tscn")

func _ready():
	active_weapon = game_manager.get_weapon_stats("basic")
	
func shoot_bullet():
	if shootTimer <= 0:
		shootTimer = active_weapon.cooldown
		var bullet = BULLET.instantiate()
		bullet.position = gun_tip.global_position 
		var bullet_stats = active_weapon
		var bullet_rotation = (get_global_mouse_position() - gun_tip.global_position).angle()
		bullet.initialize(bullet_rotation, bullet_stats)
		get_tree().current_scene.add_child(bullet)

func _input(event: InputEvent) -> void:
		
	if event.is_action_pressed("build"):
		# scan for resources=
		if build_range.is_valid_site():
			var build_location: Node2D = build_range.get_valid_site()
			game_manager.make_miner(build_location)
			
	if event.is_action_pressed("Weapon 1"):
		active_weapon = game_manager.get_weapon_stats("basic")
		
	if event.is_action_pressed("Weapon 2"):
		active_weapon = game_manager.get_weapon_stats("fast")
		

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
		shoot_bullet()
		
	if shootTimer >= 0:
		shootTimer -= delta
		

	move_and_slide()
