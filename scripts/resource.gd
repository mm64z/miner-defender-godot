extends Node2D

const resource_map = {
	"iron": "res://assets/images/Resource-Iron.png"
}

var resource = {
	"type": "iron",
	"hardness": 20,
}

var miner_built = false

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var miner: StaticBody2D = $Miner

func initalize(inc_resource):
	resource = inc_resource
	change_sprite(resource.type)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_sprite(resource.type)

func change_sprite(resource_type):
	sprite_2d.texture = load(resource_map[resource_type])
	
func build_miner(game_manager, miner_info):
	if !miner_built:
		miner_built = true
		sprite_2d.hide()
		miner.process_mode = Node.PROCESS_MODE_INHERIT
		miner.initialize(game_manager, resource, miner_info)
		
	
