extends KinematicBody2D
class_name Mob

export (int) var max_health: int = 100
export (int) var speed: int = 120
export (float) var friction: float = 0.1
export (float) var acceleration: float = 0.1

var current_health: int = max_health
var velocity: Vector2 = Vector2()
var facing_right: bool = true
var animate_while_moving_flag: bool = true

func _ready() -> void:
	setup_health_bar()

func _physics_process(delta) -> void:
	check_for_death()

func move(direction):
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
	velocity = move_and_slide(velocity)
	animate_while_moving()
	
func animate_while_moving() -> void:
	var upscale = 1.2
	var downscale = 1
	var anim_speed = 0.2
	
	if $Sprite.scale.y <= downscale + 0.01:
		animate_while_moving_flag = true;
	elif $Sprite.scale.y >= upscale - 0.1:
		animate_while_moving_flag = false;
		
	if velocity.length() > 0.2:
		if animate_while_moving_flag:
			$Sprite.scale.y = lerp($Sprite.scale.y, upscale, anim_speed)
		else:
			$Sprite.scale.y = lerp($Sprite.scale.y, downscale, anim_speed)
	else:
		$Sprite.scale.y = lerp($Sprite.scale.y, downscale, anim_speed)

func lose_health(amount) -> void:
	current_health -= amount
	update_health_bar()

func restore_health(amount) -> void:
	current_health += amount
	if current_health > max_health:
		current_health = max_health
	update_health_bar()

func check_for_death() -> void:
	if current_health <= 0:
		self.queue_free()

func update_health_bar() -> void:
	if has_node("HealthBar"):
		$HealthBar.value = current_health

func setup_health_bar() -> void:
	if has_node("HealthBar"):
		$HealthBar.max_value = max_health
		update_health_bar()
