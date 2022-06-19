extends Node2D

export (PackedScene) var enemy

var player_position
var enemies = []
var time_until_next_enemy = 3
var rng = RandomNumberGenerator.new()

func _ready():
	pass

func _process(delta):
	time_until_next_enemy -= delta
	print(time_until_next_enemy)
	if time_until_next_enemy < 0:
		time_until_next_enemy = 3
		spawn_enemy()
	player_position = $Player.position

func spawn_enemy():
	var enemy_to_spawn = enemy.instance()
	self.add_child(enemy_to_spawn)
	var random_position = Vector2(rng.randf_range(-100.0, 100.0), rng.randf_range(-100.0, 100.0))
	enemy_to_spawn.position = $Player.position + random_position
