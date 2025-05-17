extends Control

var main_scene = preload("res://main.tscn")
@onready var anim_player = $AnimationPlayer

func _ready() -> void:
	anim_player.play("fade")
	await anim_player.animation_finished
	add_child(main_scene.instantiate())
