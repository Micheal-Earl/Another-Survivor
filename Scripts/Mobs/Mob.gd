extends KinematicBody2D
class_name Mob

export (int) var health = 100
export (int) var speed = 120
export (float) var friction = 0.1
export (float) var acceleration = 0.1

var velocity = Vector2()
var facing_right = true
var animate_while_moving_flag = true

func _ready():
	pass # Replace with function body.

func move(direction):
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
	velocity = move_and_slide(velocity)
	animate_while_moving()

func animate_while_moving() -> void:
	if $Sprite.scale.y <= 1.01:
		animate_while_moving_flag = true;
	elif $Sprite.scale.y >= 1.13:
		animate_while_moving_flag = false;
	if velocity.length() > 1:
		if animate_while_moving_flag:
			$Sprite.scale.y = lerp($Sprite.scale.y, 1.14, 0.3)
		else:
			$Sprite.scale.y = lerp($Sprite.scale.y, 1, 0.3)
	else:
		$Sprite.scale.y = lerp($Sprite.scale.y, 1, 0.3)
