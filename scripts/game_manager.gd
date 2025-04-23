extends Node

@onready var player: CharacterBody2D = %Player
const ENEMY = preload("res://scenes/enemy.tscn")
@onready var camera_2d: Camera2D = $"../Player/Camera2D"
var rng = RandomNumberGenerator.new()
const MINER = preload("res://scenes/miner.tscn")
@onready var game_manager: Node = %GameManager

var enemy_stats = {}
var weapon_stats = {}
var miner_stats = {}
var resource_stats = {}

func _ready():
	var file = FileAccess.open("res://data/enemy_data.json", FileAccess.READ)
	if file:
		var content = file.get_as_text()
		enemy_stats = JSON.parse_string(content)
	else: 
		print("ERROR in loading enemy")
		
	file = FileAccess.open("res://data/weapon_data.json", FileAccess.READ)
	if file:
		var content = file.get_as_text()
		weapon_stats = JSON.parse_string(content)
	else: 
		print("ERROR in loading weapon")
	
	file = FileAccess.open("res://data/miner_data.json", FileAccess.READ)
	if file:
		var content = file.get_as_text()
		miner_stats = JSON.parse_string(content)
	else: 
		print("ERROR in loading miners")
		
	file = FileAccess.open("res://data/resource_data.json", FileAccess.READ)
	if file:
		var content = file.get_as_text()
		resource_stats = JSON.parse_string(content)
	else: 
		print("ERROR in loading resources")
		
func get_weapon_stats(type: String) -> Dictionary:
	return weapon_stats[type]

func spawn_enemy(enemy_type: String, position: Vector2):
	var newEnemy = ENEMY.instantiate()
	newEnemy.global_position = position
	newEnemy.initialize(player, enemy_stats[enemy_type])
	get_tree().current_scene.add_child(newEnemy)

func _on_timer_timeout() -> void:
	# spawn an enemy around the player
	var spawnAngle = rng.randf_range(0,2*PI)
	var spawnDistance = 500 # TODO: figure out offscreen
	var new_position = player.global_position + Vector2.RIGHT.rotated(spawnAngle)*spawnDistance
	spawn_enemy("basic", new_position)
	
func make_miner(node: Node2D):
	# TODO check it has this func
	node.build_miner(game_manager, miner_stats["basic"])
	#var miner = MINER.instantiate()
	#miner.position = node.global_position
	## TODO give miner info (maybe ask game manager?)
	#miner.initialize()
	#get_tree().current_scene.add_child(miner)
	
var resources = {}
@onready var resources_display: RichTextLabel = %Resources
func increase_resource(type: String, amount: int):
	if type in resources:
		resources[type] += amount
	else: 
		resources[type] = 0 + amount
	update_resource_display()
		
func update_resource_display():
	var text_to_add = ""
	for type in resources:
		text_to_add +=  "%s: %s \n" % [type, resources[type]]
	resources_display.text = text_to_add
		
