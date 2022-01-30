extends Node

var camera = null
var bullet_pool = null
var bullet_manager = null
var score_text = null
var score = 0 setget _score_set
var player = null
var hs = 0
var current_difficulty = 1

const SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"

func save_data():
	var data = {
		"hs": 0,
	}
	if Globals.score > Globals.hs:
		Globals.hs = Globals.score
		data["hs"] = Globals.score
	else:
		data["hs"] = Globals.hs
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)

	var file = File.new()
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, "P@paB3ar6969")
	if error == OK:
		file.store_var(data)
		file.close()

func load_data():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ, "P@paB3ar6969")
		if error == OK:
			var data = file.get_var()
			file.close()
			return data

func _ready():
	var data = load_data()
	hs = data["hs"]
	
func _score_set(_score):
	score = _score
	if score_text != null:
		score_text.update_text()
