extends KinematicBody2D

onready var timer = $destroy_timer
var velocity := Vector2.ZERO
var speed := 100

enum DIRECTION{
	LEFT,
	RIGHT
}

var dir = DIRECTION.LEFT

func _ready():
	timer.start()
	if speed > (480.0 + (480.0 * (Globals.current_difficulty / 5.0))):
		Globals.camera.shake(300, 1, 300)
		Globals.player.shake_world()

func move(delta):
	if dir == DIRECTION.LEFT:
		velocity.x -= 1 * speed * delta
	else:
		velocity.x += 1 * speed * delta
	velocity = move_and_slide(velocity)

func can_get_score() -> bool:
	return ((dir == DIRECTION.LEFT and position.x < 0) or (dir == DIRECTION.RIGHT and position.x > 550)) and not Globals.player.is_dying

func _process(delta):
	move(delta)

	if can_get_score():
		Globals.score += 1
		queue_free()

func _on_Area2D_area_entered(area):
	if area.get_parent().name == "player":
		area.get_parent().destroy()
		queue_free()

func _on_destroy_timer_timeout():
	Globals.score += 1
	queue_free()
