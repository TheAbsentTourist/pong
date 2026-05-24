extends CharacterBody2D

@onready var score_label: Label = $"../Score"

const speed: int = 200 * 100
var score: int = 0
var can_score: bool = true
var paused: bool = false
var mouse_controls: bool = false
var target_y: float = 0.0
var mouse_sensitivity: float = 0.3

#Pause doohickeys.
func pause():
	Engine.time_scale = 0.0
	

func unpause():
	Engine.time_scale = 1.0
	


func _ready():
	score_label.text = str(score)
	
	#Gets W and S and converts them to vertical movement.
func _physics_process(delta: float) -> void:
	if mouse_controls:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
		# 1. Calculate the distance to the target
		var distance_to_target = target_y - global_position.y
		
		# 2. Set velocity based on that distance. 
		# We multiply by a constant (e.g., 25.0) so it moves faster when far away, 
		# and slows down smoothly as it gets closer (simulating the lerp look).
		velocity.y = distance_to_target * 25.0
		
		# 3. Use move_and_slide so Godot handles collisions properly!
		move_and_slide()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		var direction = Input.get_axis("up", "down")
		velocity.y = direction * speed * delta
		move_and_slide()

func _input(event):
	if mouse_controls and event is InputEventMouseMotion:
		target_y += event.relative.y * mouse_sensitivity

#Adds 1 to score every time the area2d node is entered.
func _on_area_2d_body_entered(_body: Node2D) -> void:
	if can_score:
		score = score + 1
		can_score = false
		await get_tree().create_timer(0.1).timeout
		can_score = true
		score_label.text = str(score)

#Handles score updating and pausing every frame.
func _process(_delta: float):
	if Input.is_action_just_pressed("Pause"):
		paused = not paused
	if paused:
		pause()
	else:
		unpause()
	#This toggles mouse controls when M is pressed.
	if Input.is_action_just_pressed("toggle_mouse"):
		mouse_controls = !mouse_controls
		print(mouse_controls)
	if mouse_controls:
		target_y = global_position.y
	
