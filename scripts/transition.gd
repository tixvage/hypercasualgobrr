extends CanvasLayer

onready var anim = $transition_anim

var next_scene = null

func _ready():
	anim.set_current_animation("default")

func _spawn():
	get_tree().change_scene(next_scene)

func _on_transition_anim_animation_finished(anim_name):
	if anim_name == "default":
		queue_free()
