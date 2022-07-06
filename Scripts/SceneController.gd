extends Node2D

export (PackedScene) var enemy

var player_position
var enemies = []
var time_until_next_enemy = 0.5
var rng = RandomNumberGenerator.new()

func _ready():
	pass

func _process(delta):
	time_until_next_enemy -= delta
	if time_until_next_enemy < 0:
		time_until_next_enemy = 0.5
		spawn_enemy()
	player_position = $Player.position

func spawn_enemy():
	var enemy_to_spawn = enemy.instance()
	self.add_child(enemy_to_spawn)
	var spawn_x = rng.randi_range(100, 200)
	var spawn_y = rng.randi_range(100, 200)
	if rng.randi_range(0, 1) == 1:
		spawn_x = -spawn_x
	if rng.randi_range(0, 1) == 1:
		spawn_y = -spawn_y
	var random_position = Vector2(spawn_x, spawn_y)
	enemy_to_spawn.position = $Player.position + random_position
