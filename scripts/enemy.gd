extends RigidBody2D

var player: CharacterBody2D
@onready var enemy: RigidBody2D = $"."
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var game_manager: Node = %GameManager

var SPEED = 1
var MAX_SPEED = 100
var HEALTH = 100

# backup for when initialize not called
func _ready():
	if player == null:
		player = get_tree().current_scene.find_child("Player", true, false)

func initialize(p: CharacterBody2D, stats: Dictionary):
	player = p
	# TODO enum?
	SPEED = stats.get("accel", SPEED)
	MAX_SPEED = stats.get("max_speed", MAX_SPEED)
	HEALTH = stats.get("health", HEALTH)

func _physics_process(delta: float) -> void:
	
	# get a vector to the player
	var vector = player.global_position - enemy.global_position
	
	# face the player
	enemy.rotation = vector.angle()
	
	# move toawrds player
	enemy.apply_central_force (vector * SPEED)
	if linear_velocity.length() > MAX_SPEED:
		linear_velocity = linear_velocity.normalized() * MAX_SPEED

func _on_body_entered(body: Node) -> void:
	if body.has_method("get_damage"):
		take_damage(body.get_damage())
		
func take_damage(damage: int) -> void:
	HEALTH -= damage
	if HEALTH <= 0:
		animation_player.play("destroy")
