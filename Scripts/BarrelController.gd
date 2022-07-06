extends StaticBody2D

export (PackedScene) var explosion

func explode() -> void:
	self.queue_free()

func _physics_process(_delta):
	if self.is_queued_for_deletion():
		var explosion_instance = explosion.instance()
		get_tree().get_root().add_child(explosion_instance)
		explosion_instance.transform = self.global_transform
