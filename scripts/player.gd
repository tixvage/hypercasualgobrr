extends KinematicBody2D

var jump_force :float = -20000
var gravity :float = 500
var velocity := Vector2.ZERO
const UP = Vector2(0, -1)

var is_dying := false

onready var die_tween = $die_tween
onready var shake_tween = $shake_tween
onready var sprite = $Sprite
onready var area2d = $Area2D
onready var die_sound = $die_sound
onready var jump_sound = $jump_sound
onready var jump_effect = $jump_effect

var rng := RandomNumberGenerator.new()

func prepare_die_tween():
	die_tween.interpolate_property(sprite.get_material(), "shader_param/progress",
		0.0, 0.75, 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

func before_dying():
	prepare_die_tween()
	die_sound.play()
	is_dying = true
	area2d.queue_free()
	die_tween.start()

func destroy():
	Globals.score_text = null
	before_dying()

func shake_world():
	shake_tween.interpolate_property(get_node("Sprite"), "rotation_degrees",
		rotation_degrees, rng.randi_range(0, 360), 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	shake_tween.start()

func _ready():
	rng.randomize()
	Globals.player = self

func jump(delta):
	jump_sound.play()
	jump_effect.restart()
	velocity.y = jump_force * delta

func gravity(delta):
	velocity.y += gravity * delta

func _process(delta):
	if is_dying: return

	gravity(delta)
	if Input.is_action_just_pressed("jump"):
		jump(delta)

	velocity = move_and_slide(velocity, UP)

func _on_die_tween_tween_all_completed():
	get_tree().change_scene("res://scenes/final.tscn")



func _on_Area2D_area_entered(area):
	if area.is_in_group("wall"):
		destroy()
		pass
