extends Area2D

var lifetime: float = 0.6

func _ready():
	var sprite = $Sprite
	sprite.texture.current_frame = 0

func _physics_process(delta):
	lifetime -= delta
	if lifetime <= 0:
		self.queue_free()

func _on_Explosion_body_entered(body):
	if body.is_in_group("player") or body.is_in_group("mobs"):
		body.lose_health(20)
