extends StaticBody2D

@onready var gameover_label: Label = $"..s/GameOver"

var game_over: bool = false


func freeze_game() -> void:
	Engine.time_scale = 0.0

func unfreeze_game() -> void:
	Engine.time_scale = 1.0

#When triggered by the death-box thingy this changes the game over variable
#and does the trigger stuff for the freezing and unfreezing.
#Game over variable is also used in blackout script.
func _on_area_2d_body_entered(_body: Node2D):
	game_over = true
	gameover_label.text = "game over"
	freeze_game()
func _process(_delta: float) -> void:
		if Input.is_anything_pressed() and game_over:
			get_tree().reload_current_scene()
			unfreeze_game()
			game_over = false
