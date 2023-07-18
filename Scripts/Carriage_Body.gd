extends CharacterBody2D
var force = Vector2(100, 0)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Called every frame. 'delta' is the elapsed time since the previous frame.
@onready var _animated_sprite = $AnimatedSprite2D
func _ready():
	_animated_sprite.play("default")



func _process(delta):
	velocity.x = force.x
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

func increase_speed(speed):
	force = Vector2(speed, 0)
