extends Area2D

var player_reference: Player
var direction_to_player: Vector2
var speed = 100

onready var global = get_node("/root/Global")

func _ready():
	player_reference = global.player
	
func _physics_process(delta):
	if global_transform.origin.distance_to(player_reference.global_transform.origin) < 50:
		direction_to_player = (player_reference.global_transform.origin - self.global_transform.origin).normalized()
		self.position += direction_to_player * speed * delta

func _on_XP_body_entered(body):
	if body.is_in_group("player"):
		body.gain_experience(500)
		self.queue_free()
