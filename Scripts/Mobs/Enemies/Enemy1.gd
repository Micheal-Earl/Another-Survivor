extends Mob

var player_reference: Player
var direction_to_player: Vector2

func _ready():
	speed = 40
	max_health = 30
	current_health = max_health
	._ready()

func _physics_process(delta):
	._physics_process(delta)
	player_reference = get_parent().get_node("./Player")
	direction_to_player = (player_reference.global_transform.origin - self.global_transform.origin).normalized()
	move(direction_to_player)
