extends Node2D

var rng := RandomNumberGenerator.new()
var timer := Timer.new()

onready var jump_over = load("res://scenes/jump_over.tscn")

func _ready():
	rng.randomize()

func _process(delta):
	pass
