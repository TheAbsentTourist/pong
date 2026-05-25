extends Node2D


func _on_exit_pressed() -> void:
	var scene_path = "uid://fc1xsaogevib"
	get_tree().change_scene_to_file(scene_path)
