extends Node2D

onready var score_text = $score
onready var hs_text = $hs

const SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"

func _ready():
	score_text.text = str("score:" + str(Globals.score))
	if Globals.score > Globals.hs:
		hs_text.text = str("hs:" + str(Globals.score))
	else:
		hs_text.text = str("hs:" + str(Globals.hs))
	
	Globals.save_data()

func _on_Button_pressed():
	Globals.score = 0
	get_tree().change_scene("res://scenes/world.tscn")
