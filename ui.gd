extends CanvasLayer

@onready var timer_label = $TimerLabel
@onready var game_over_label = $GameOverLabel
@onready var game_timer = $"../GameTimer"

func _ready():
	game_over_label.visible = false
	game_timer.start()

func _process(delta):
	var time_left = int(game_timer.time_left)
	timer_label.text = "⏳ Time Left: " + str(time_left)

	if time_left <= 0:
		game_over()

func game_over():
	game_over_label.visible = true
	game_over_label.text = "⏰ Time's Up! You Lose!"
	timer_label.visible = false
	get_tree().paused = true  # stop the game
