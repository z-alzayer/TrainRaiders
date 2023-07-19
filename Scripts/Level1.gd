extends Node2D
@onready var tileset = $Rail
@onready var player = $Player
var carriage = preload("res://Nodes/CarriageBody.tscn")
var CONST_DIST = 100
var CARRIAGE_FREQ = 10
var max_generated
var CARRIAGE_SPEED = 1.05
var timeout = 0
var total_delta = 0
var player_speed = 800
var timeout_counter = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(-100, CONST_DIST + 1):
		tileset.set_cell(0, (Vector2i(i, 1)), 1, Vector2i(0,0))
		max_generated = i

func create_new_area(min):

	var distance =  min 
	if distance < max_generated:
		return
	for i in range(distance, distance + CONST_DIST):

		tileset.set_cell(0, (Vector2i(i, 1)), 1, Vector2i(0,0))
		max_generated = i


func check_player_pos():
	if player.position.x > (tileset.local_to_map(Vector2i(max_generated, 0)).x / 2):
		create_new_area(max_generated)
		
	if timeout > .65:

		create_new_carriage()
		timeout = 0
		timeout_counter += 1

func create_new_carriage():
	var new_carriage = carriage.instantiate()
	add_child(new_carriage)
	var body = new_carriage.find_child("Carriage_Body")
	body.set_position(Vector2(player.position.x + 100, -10))
	body.increase_speed(100 + (CARRIAGE_SPEED  * total_delta))
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	timeout += delta
	total_delta += delta
	check_player_pos()
	if str(total_delta)[-1] == '0' and timeout_counter % 2 == 0:
		player.increase_speed(100 + (player_speed  * total_delta))
		
