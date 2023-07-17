extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -700.0
var double_jump
var jump_counter

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	double_jump = true
	jump_counter = 1

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and double_jump:
		velocity.y = JUMP_VELOCITY
		jump_counter -= 1
	
	if jump_counter == 0:
		double_jump = false
	
	if is_on_floor():
		jump_counter = 1
		double_jump = true
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	apply_floor_snap()
	move_and_slide()
