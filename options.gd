extends Control

# 1. Add a reference to your HSlider node (adjust the path "$HSlider" if yours is named differently)
@onready var sens_slider: HSlider = $Sens_Slide
@onready var sens_label: Label = $Sens_Slide/Sens_Label

const SAVE_PATH = "user://settings.cfg"

var current_sensitivity: float = 5.0

func _ready() -> void:
	sens_label.text = "CURRENT SENSITIVITY: " + "%.2f" % current_sensitivity

func _on_h_slider_value_changed(new_mouse_sensitivity: float) -> void:
	current_sensitivity = new_mouse_sensitivity
	sens_label.text = "CURRENT SENSITIVITY: " + "%.2f" % current_sensitivity


func _on_exit_pressed() -> void:
	save_settings()
	var scene_path = "uid://fc1xsaogevib"
	get_tree().change_scene_to_file(scene_path)


func save_settings():
	var config = ConfigFile.new()
	
	# Set_value takes: (Section_Name, Key_Name, Value)
	config.set_value("Controls", "mouse_sensitivity", current_sensitivity)
	
	# Save it to the device
	var error = config.save(SAVE_PATH)
	if error != OK:
		print("Failed to save settings! Error code: ", error)


func _on_reset_pressed() -> void:
	# 2. Update the actual slider UI value
	sens_slider.value = 5.0
