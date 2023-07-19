extends CharacterBody2D


var SPEED = 750.0
const JUMP_VELOCITY = -1000.0
var double_jump
var jump_counter
var direction
@onready var _walking_animation = $AnimatedSprite2D
@onready var cat_animation = $Cat/AnimatedSprite2D
@onready var position_node = $Node
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var grenade = preload("res://Nodes/Projectile.tscn")

func increase_speed(speed):
	SPEED = speed

func _ready():
	double_jump = true
	jump_counter = 1

func _physics_process(delta):
	# Add the gravity.

	if not is_on_floor():
		velocity.y += gravity * delta
	
	if velocity.x != 0 and is_on_floor():
		_walking_animation.play()
		_walking_animation.play("default")
		cat_animation.play("walk")
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and double_jump:

		_walking_animation.play("jump")
		cat_animation.play("jump")
		_walking_animation.set_frame_and_progress(0,0)
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_released("ui_down"):
		throw_grenade()
#	if velocity.y < 0:
#		_walking_animation.set_frame_and_progress(0,.5)
	
	if jump_counter == 0:
		double_jump = false
	
	if is_on_floor():
		jump_counter = 1
		double_jump = true
	if is_on_floor() and velocity.x == 0:


		_walking_animation.play("idle")
		cat_animation.play("idle")
		

	
	if not is_on_floor():
		_walking_animation.play("jump")
		cat_animation.play("jump")
		jump_counter -= 1
		
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		_walking_animation.scale.x = direction
		velocity.x = direction * SPEED
	else:
		
		velocity.x = move_toward(velocity.x, 0, SPEED)
	apply_floor_snap()
	move_and_slide()

func throw_grenade():
	
	print("Throwing grenade")


	var new_grenade = grenade.instantiate()
	add_sibling(new_grenade)
	new_grenade.position = Vector2(self.position.x + (_walking_animation.scale.x * 10), self.position.y)


func _on_animated_sprite_2d_animation_finished():
	_walking_animation.stop()
