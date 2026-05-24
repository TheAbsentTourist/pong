extends CharacterBody2D

# Speed configuration
var initial_speed: float = 200.0
var current_speed: float = 200.0
var speed_increment: float = 2.0  # How much faster it gets per bounce
var max_speed: float = 800.0       # The absolute top speed cap

@onready var other_character: CharacterBody2D = $"../Player"


#Absolute LLM magic nonsense code, I understand any of the physics here but
#they do work so I am not going to touch it and neither should you, future me.
func _ready() -> void:
	# Start by giving the ball a normalized direction, then multiply by speed
	var initial_direction = Vector2(1, 1).normalized()
	velocity = initial_direction * current_speed

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
#	print(velocity)
	
	if collision:
		# 1. Standard physics bounce
		var bounce_direction = velocity.bounce(collision.get_normal()).normalized()
		
		# 2. Apply player english ONLY if hitting a player paddle
		# (Checking if the collider name contains "Player" or "Enemy")
		if "Player" in collision.get_collider().name or "Paddle" in collision.get_collider().name:
			bounce_direction.y += (other_character.velocity.y * 0.002)
		
		# 3. Prevent extreme vertical angles (The Fix!)
		# We force the horizontal direction (X) to always be at least 35% of the trajectory
		var min_x_push = 0.80
		if abs(bounce_direction.x) < min_x_push:
			# Restore X to the minimum, keeping its original left/right sign (-1 or 1)
			bounce_direction.x = sign(bounce_direction.x) * min_x_push
		
		# 4. Re-normalize after adjustments so the vector length is exactly 1
		bounce_direction = bounce_direction.normalized()
		
		# 5. Step up the speed and apply it
		current_speed = min(current_speed + speed_increment, max_speed)
		velocity = bounce_direction * current_speed
