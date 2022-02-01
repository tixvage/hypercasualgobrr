extends Node

var tween_x = Tween.new()
var tween_y_1 = Tween.new()
var tween_y_2 = Tween.new()

func jump_left():
	tween_x.interpolate_property(Globals.player, "position:x",
	Globals.player.position.x, Globals.player.position.x - 120, 0.5,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween_x.connect("tween_all_completed", self, "_tween_x_end")
	add_child(tween_x)
	tween_x.start()
	
	tween_y_1.interpolate_property(Globals.player, "position:y",
	Globals.player.position.y, Globals.player.position.y - 100, 0.25,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween_y_1.connect("tween_all_completed", self, "_tween_y_1_end")
	add_child(tween_y_1)
	tween_y_1.start()

func jump_right():
	tween_x.interpolate_property(Globals.player, "position:x",
	Globals.player.position.x, Globals.player.position.x + 120, 0.5,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween_x.connect("tween_all_completed", self, "_tween_x_end")
	add_child(tween_x)
	tween_x.start()
	
	tween_y_1.interpolate_property(Globals.player, "position:y",
	Globals.player.position.y, Globals.player.position.y - 100, 0.25,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween_y_1.connect("tween_all_completed", self, "_tween_y_1_end")
	add_child(tween_y_1)
	tween_y_1.start()

func _tween_y_1_end():
	tween_y_2.interpolate_property(Globals.player, "position:y",
		Globals.player.position.y, Globals.player.position.y + 100, 0.25,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	add_child(tween_y_2)
	tween_y_2.start()

func _tween_x_end():
	queue_free()
