extends Control

var high_score : int = 0
var speed : float = 0.0

func _ready() -> void:
	$TitleContainer/Title/AnimationPlayer.play(("move"))
	$Save.visible = false
	var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	if not file:
		$Load.visible = false
	else:
		file.close()

func save_to_file(content) -> void:
	var file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	file.store_64(content)
	file.close()

func load_from_file():
	var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	var content = file.get_64()
	file.close()
	return content

func _on_save_pressed() -> void:
	save_to_file(high_score)
	$Load.visible = true

func _on_load_pressed() -> void:
	var score = load_from_file()
	high_score = int(score)
	speed = high_score * 0.1
	$Save.visible = true

func animate_title(_delta : float) -> void:
	pass

func _process(delta: float) -> void:
	animate_title(delta)
	$Dog.rotation += speed * delta
	$Score.text = "Score: " + str(high_score)

func _on_dog_pressed() -> void:
	$Save.visible = true
	high_score += 1
	speed += 0.1
