extends RigidBody2D

var SPEED = 500
@onready var bullet: RigidBody2D = $"."
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	bullet.linear_velocity = Vector2.RIGHT.rotated(rotation) * SPEED

func _process(delta):
	pass
	#position += Vector2.RIGHT.rotated(rotation) * speed * delta


func _on_body_entered(body: Node) -> void:
	print("contact")
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	animation_player.play("destroy")
