extends Mob

export (PackedScene) var experience

var player_reference: Player
var direction_to_player: Vector2

func _ready():
	speed = 40
	max_health = 30
	current_health = max_health
	._ready()

func _physics_process(delta):
	handle_collisions()
	player_reference = get_parent().get_node("./Player")
	direction_to_player = (player_reference.global_transform.origin - self.global_transform.origin).normalized()
	move(direction_to_player)
	spawn_experience_on_death()
	._physics_process(delta)

func spawn_experience_on_death() -> void:
	if current_health <= 0:
		var exp_to_spawn = experience.instance()
		get_tree().get_root().add_child(exp_to_spawn)
		exp_to_spawn.transform = self.global_transform

func handle_collisions() -> void:
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("player"):
			collision.collider.lose_health(10)
		print("I collided with ", collision.collider.name)
