extends Node2D

onready var resokt_anim = $resokt/AnimationPlayer

func _ready():
	resokt_anim.set_current_animation("default")

func _on_play_button_pressed():
	Globals.change_scene("res://scenes/world.tscn")

func _on_shop_button_pressed():
	Globals.change_scene("res://scenes/shop.tscn")
