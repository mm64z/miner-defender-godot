extends StaticBody2D

@onready var game_manager: Node = %GameManager
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var miner: StaticBody2D = $"."

var mineTimer = 0

var miner_info = {
	"damage": 10, # damage per second
}
var resource = {
	"type": "iron",
	"hardness": 20,
} 

# from resource_data and miner_data respectively
func initialize(inc_game_manager, resource_type, miner_type):
	game_manager = inc_game_manager
	resource = resource_type
	miner_info = miner_type
	miner.visible = true
	animated_sprite_2d.play()
	

func _physics_process(delta: float) -> void:
	mineTimer += delta * miner_info.damage
	if mineTimer >= resource.hardness:
		game_manager.increase_resource(resource.type, 1)
		mineTimer = 0
