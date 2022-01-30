extends Node2D

var rng := RandomNumberGenerator.new()
var spawner_timer := Timer.new()
var spawned_bullets = 0

onready var bullet_scene = load("res://scenes/bullet.tscn")
onready var bullet_pool = get_node("../BulletPool")
onready var lesgo_sound = $lesgo_sound

func get_randf_timer() -> float:
	return rng.randf_range(0.2, 1)

func setup_timer():
	spawner_timer.connect("timeout", self, "_on_spawner_timer_timeout")
	spawner_timer.set_wait_time(get_randf_timer())
	add_child(spawner_timer)

func _ready():
	Globals.bullet_manager = self
	
	rng.randomize()
	
	setup_timer()
	spawner_timer.start()

func restart_timer():
	spawner_timer.set_wait_time(get_randf_timer())
	spawner_timer.start()

func check_for_difficulty():
	if spawned_bullets > Globals.current_difficulty * 10:
		Globals.current_difficulty += 1

func setup_bullet(temp_bullet):
	spawned_bullets += 1
	check_for_difficulty()
	
	var temp_vector = Vector2()
	var temp_direction = rng.randf()
	if temp_direction >= 0.5:
		temp_vector.x = -20
		temp_bullet.dir = 1
	else:
		temp_vector.x = 570
		temp_bullet.rotation_degrees = 180
	temp_vector.y = rng.randi_range(70, 650)

	var temp_speed = rng.randi_range(300.0 + (300.0 * (Globals.current_difficulty / 5.0)), 500.0 + (500.0 * (Globals.current_difficulty / 5.0)))
	lesgo_sound.play_lesgo(temp_speed)
	
	temp_bullet.position = temp_vector
	temp_bullet.speed = temp_speed

func _on_spawner_timer_timeout():
	var temp_bullet = bullet_scene.instance()
	setup_bullet(temp_bullet)
	bullet_pool.add_child(temp_bullet)
	restart_timer()
