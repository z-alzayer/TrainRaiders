extends CharacterBody2D
var force = Vector2(100, 0)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = force.x
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
