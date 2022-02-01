extends Node2D

onready var rocket_coin = $coin

func _ready():
	rocket_coin.text = "COIN: " + str(Globals.coin)

func _on_back_button_pressed():
	Globals.change_scene("res://scenes/main_menu.tscn")
