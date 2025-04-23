extends RigidBody2D

var SPEED = 500
var DAMAGE = 100
@onready var game_manager: Node = %GameManager
@onready var bullet: RigidBody2D = $"."
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
var rng = RandomNumberGenerator.new()

const image_mapping = {
	"basic": preload("res://assets/images/Bullet.png"),
	"small": preload("res://assets/images/Bullet-Small.png"),
}

var stats = {}

func _ready() -> void:
	change_sprite(stats.image)
	
func initialize(inc_rotation: float, inc_stats: Dictionary):
	stats = inc_stats
	var spread = deg_to_rad(rng.randf_range(-inc_stats.spread, inc_stats.spread))
	rotation = inc_rotation + spread
	SPEED = stats.get("speed", SPEED)
	DAMAGE = stats.get("damage", DAMAGE)
	linear_velocity = Vector2.RIGHT.rotated(rotation) * SPEED
	
func change_sprite(type):
	sprite_2d.texture = image_mapping[type]
	
func get_damage() -> int:
	return DAMAGE

func _process(delta):
	pass
	#position += Vector2.RIGHT.rotated(rotation) * speed * delta


func _on_body_entered(body: Node) -> void:
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	animation_player.play("destroy")
