extends Mob
class_name Player

onready var global = get_node("/root/Global")

export (PackedScene) var bullet

var angle = Vector2.RIGHT
var level = 1
var experience = 0
var max_immunity_time = 1
var current_immunity_time = 0

func _ready():
	Global.register_player(self)
	update_label()
	._ready()

func _process(delta):
	check_for_level_up()

func _physics_process(delta):
	current_immunity_time -= delta
	angle = (.get_global_mouse_position() - self.global_position).angle()
	flip_sprite(angle)
	move(get_input())
	._physics_process(delta)

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

func shoot():
	var b = bullet.instance()
	owner.add_child(b)
	b.transform = $"Gun/Muzzle".global_transform
	b.get_node("Sprite").rotation_degrees = 90;

func lose_health(amount):
	if current_immunity_time <= 0:
		current_immunity_time = max_immunity_time
		.lose_health(amount)
	else:
		return

func gain_experience(amount) -> void:
	experience += amount
	
func update_label() -> void:
	$Label.set_text("Lv " + str(level))

func check_for_level_up() -> void:
	if experience >= 1000:
		experience = 0
		level += 1
		update_label()
