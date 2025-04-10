extends Node

@onready var player: CharacterBody2D = %Player
const ENEMY = preload("res://scenes/enemy.tscn")
@onready var camera_2d: Camera2D = $"../Player/Camera2D"
var rng = RandomNumberGenerator.new()

func _on_timer_timeout() -> void:
	print ("timeout")
	# spawn an enemy around the player
	var newEnemy = ENEMY.instantiate()
	var spawnAngle = rng.randf_range(0,2*PI)
	var spawnDistance = 50 # idk
	newEnemy.global_position = player.global_position + Vector2.RIGHT.rotated(spawnAngle)*spawnDistance
	get_tree().current_scene.add_child(newEnemy)
	
