extends CharacterBody2D
#
@onready var train_path = get_node("/root/Level1/Path2D/PathFollow2D")
const SPEED = 1000.0
#const JUMP_VELOCITY = -400.0
#
#var train_points
#var train_index = 0
## Get the gravity from the project settings to be synced with RigidBody nodes.
##var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#var UP_CONST = 10
#
#func _ready():
#
#	train_points = train_path.curve.get_baked_points()
#
func _process(delta):
	print(get_parent().get_progress())
	get_parent().set_progress(get_parent().get_progress() +  SPEED * delta)

#func _physics_process(delta):
#	if !train_path:
#		return
#	var target = train_points[train_index]
#	print(target)
#	if position.distance_to(target) < 1:
#		print(target)
#		train_index = wrapi(train_index + 1, 0, train_points.size())
#		print("Moving")
#		target = train_points[train_index]
#	velocity = (target - position).normalized() * SPEED
#	print(velocity)
#	move_and_slide()
#
##
#	# Moves train up
#	velocity.y -= UP_CONST * delta
#
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
#
#	move_and_slide()
