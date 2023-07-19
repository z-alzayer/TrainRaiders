extends CharacterBody2D

@onready var animation = $AnimatedSprite2D
@onready var timer = $Timer
const SPEED = 1000
const JUMP_VELOCITY = -400.0

var total_delta = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	animation.play("grenade")
	timer.start()

	
func get_player_direction():
	return -1
	

func _process(delta):

	velocity.x = SPEED * delta
	move_and_slide()
	print(self.position)
#	while total_delta < 5:
##		velocity.y = JUMP_VELOCITY
	if not is_on_floor():
		velocity.y += gravity * delta
#		var direction = get_player_direction()
#		velocity.x = direction * SPEED
#		total_delta += delta
#		move_and_slide()
#




func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("Entering body")
#	body.queue_free()


func _on_timer_timeout():
	print("timer ended")
	animation.play("explosion")




func _on_animated_sprite_2d_animation_finished():
	print("Animation finished")
	queue_free()
