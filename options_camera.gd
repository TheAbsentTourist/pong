extends Camera2D

var scroll_speed: int = 9000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("scroll_down"):
		position.y = position.y + scroll_speed * delta
	if Input.is_action_just_pressed("scroll_up"):
		position.y = position.y - scroll_speed * delta
