extends Control



func _on_arcade_button_pressed() -> void:
	var scene_path = "uid://da8nnse7hu2wu"
	get_tree().change_scene_to_file(scene_path)


func _on_classic_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
