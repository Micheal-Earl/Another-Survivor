extends Mob
class_name Player

onready var global = get_node("/root/Global")

export (PackedScene) var bullet

var movement_velocity = Vector2()
var angle = Vector2.RIGHT
var level = 1
var experience = 0
var max_immunity_time = 1
var current_immunity_time = 0
var max_shoot_cooldown: float = 0.3
var shoot_cooldown: float = 0

func _ready():
	Global.register_player(self)
	update_label()
	._ready()

func _process(_delta):
	check_for_level_up()

func _physics_process(delta):
	current_immunity_time -= delta
	shoot_cooldown -= delta
	print(shoot_cooldown)
	angle = (.get_global_mouse_position() - self.global_position).angle()
	flip_sprite(angle)
	move(movement_velocity)
	._physics_process(delta)

func get_input():
	movement_velocity.x = 0
	movement_velocity.y = 0
	if Input.is_action_pressed("shoot"):
		shoot()
	if Input.is_action_pressed('right'):
		movement_velocity.x += 1
	if Input.is_action_pressed('left'):
		movement_velocity.x -= 1
	if Input.is_action_pressed('down'):
		movement_velocity.y += 1
	if Input.is_action_pressed('up'):
		movement_velocity.y -= 1

func flip_sprite(look_angle):
	if (look_angle > -1.5 and angle < 1.5) and facing_right == false:
		facing_right = true
		$Sprite.scale.x = 1
	elif (look_angle < -1.5 or angle > 1.5) and facing_right == true:
		facing_right = false
		$Sprite.scale.x = -1

func shoot():
	if shoot_cooldown <= 0:
		var b = bullet.instance()
		owner.add_child(b)
		b.transform = $"Gun/Muzzle".global_transform
		b.get_node("Sprite").rotation_degrees = 90;
		shoot_cooldown = max_shoot_cooldown

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
