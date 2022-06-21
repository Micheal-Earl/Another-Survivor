extends Node

# TODO:
# Change all locally defined references to player to globally defined
# Make it so xp keeps following even when out of initial pickup range
# idk some other stuff

var player: Player

func register_player(_player) -> void:
	player = _player
