extends Sprite2D

@onready var static_body = $"../StaticBody2D"

#Doohickey that either shows or hides blackout depending on game over state.
func _process(_delta: float) -> void:
	if static_body.game_over:
		show()
	else:
		hide() 
