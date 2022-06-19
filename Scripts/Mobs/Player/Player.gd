extends Mob
class_name Player

export (PackedScene) var bullet

var angle = Vector2.RIGHT

func _ready():
	pass

func _physics_process(delta):
	angle = (.get_global_mouse_position() - self.global_position).angle()
	flip_sprite(angle)
	move(get_input())

func get_input():
	if Input.is_action_just_pressed("shoot"):
		shoot()
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.y += 1
	if Input.is_action_pressed('up'):
		input.y -= 1
	return input

func flip_sprite(look_angle):
	if (angle > -1.5 and angle < 1.5) and facing_right == false:
		facing_right = true
		$Sprite.scale.x = 1
	elif (angle < -1.5 or angle > 1.5) and facing_right == true:
		facing_right = false
		$Sprite.scale.x = -1

func move(direction):
	.move(direction)

func shoot():
	var b = bullet.instance()
	owner.add_child(b)
	b.transform = $"Gun/Muzzle".global_transform
	b.get_node("Sprite").rotation_degrees = 90;
