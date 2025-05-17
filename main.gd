extends Control

var high_score: int = 0
var speed: float = 0.0
var speed_increase: float = 0.1

@onready var save_button = %SaveContainer
@onready var load_button = %LoadContainer
@onready var anim_player = %AnimationPlayer
@onready var dog = $Dog
@onready var score_label = $Score
@onready var title_label = %Title

func _ready() -> void:
	anim_player.play("move")
	save_button.visible = false
	var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	if file == null:
		load_button.visible = false
	else:
		file.close()

func save_to_file(content) -> void:
	var file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	file.store_64(content)
	file.close()

func load_from_file():
	var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	if file == null: return null
	var content = file.get_64()
	file.close()
	return content

func _on_save_pressed() -> void:
	save_to_file(high_score)
	load_button.visible = true

func _on_load_pressed() -> void:
	var score = load_from_file()
	if score == null: return
	high_score = int(score)
	speed = high_score * speed_increase
	save_button.visible = true

func _process(delta: float) -> void:
	dog.rotation += speed * delta
	score_label.text = "Score: %d" % high_score

func _on_dog_pressed() -> void:
	if not save_button.visible:
		save_button.show()
	high_score += 1
	speed += speed_increase
	if high_score < 0:
		title_label.text = "You cheating???"
		save_button.hide()
