extends RigidBody2D

@onready var player: CharacterBody2D = %Player
@onready var enemy: RigidBody2D = $"."

const SPEED = 100

func _physics_process(delta: float) -> void:
	
	# get a vector to the player
	var vector = player.global_position - enemy.global_position
	
	# face the player
	enemy.rotation = vector.angle()
	
	# move toawrds player
	enemy.linear_velocity = Vector2.RIGHT.rotated(rotation) * SPEED

func _on_body_entered(body: Node) -> void:
	pass # Replace with function body.
