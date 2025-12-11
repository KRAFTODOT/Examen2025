extends Node2D

const GAME_OVER = preload("uid://poa3p8nxgroa")
var game_over_screen

@onready var sound: AudioStreamPlayer = %Sound
@onready var banana_button: Button = %"Banana button"
@onready var ball_button: Button = %"Ball button"
@onready var left_top_marker: Marker2D = %"Left-top"
@onready var right_bottom_marker: Marker2D = %"Right-bottom"
@onready var hunger_bar: Sprite2D = %"Hunger bar"
@onready var happines_bar: Sprite2D = %"Happines bar"

var left_top
var right_bottom

var max_hunger
var current_hunger
var max_happines
var current_happines


const BALL = preload("uid://b674ep5cr4ocn")
const BANANA = preload("uid://ce8jf405bkf03")

func _ready() -> void:
	left_top=left_top_marker.position 
	right_bottom=right_bottom_marker.position
	# Markers for spawning objects in exact area
	
	max_hunger=hunger_bar.scale.y
	current_hunger=max_hunger
	#Automaticly detects size of hunger bar to change it later
	
	max_happines=happines_bar.scale.y
	current_happines=max_happines
	#Automaticly detects size of happines bar to change it later

func _process(delta: float) -> void:
	current_hunger-=10*delta
	if current_hunger<=0:
		current_hunger=0
	hunger_bar.scale.y=current_hunger
	# Shows yor level of hunger
	
	current_happines-=10*delta
	if current_happines<=0:
		current_happines=0
	happines_bar.scale.y=current_happines
	# Shows your current level of happines
	
	if current_hunger<=0 or current_happines<=0:
		game_over_screen=GAME_OVER.instantiate()
		add_child(game_over_screen)
		# Makes your game over when either hunger or happines becomes 0

func _on_banana_button_pressed() -> void:
	var x=randi_range(left_top.x,right_bottom.x)
	var y=randi_range(left_top.y,right_bottom.y)
	var banana=BANANA.instantiate()
	banana.position=Vector2(x,y)
	banana.connect("banana_eaten",_on_banana_eaten) # Connect the signal of eating banana
	# Spawns bananas in the random spot of the top area of the screen
	add_child(banana)


func _on_ball_button_pressed() -> void:
	var x=randi_range(left_top.x,right_bottom.x)
	var y=randi_range(left_top.y,right_bottom.y)
	var ball=BALL.instantiate()
	ball.set_modulate(Color(randf_range(0.4,1),randf_range(0.4,1),randf_range(0.4,1)))
	ball.position=Vector2(x,y)
	ball.connect("ball_hit",_on_ball_hit)
	# Spawns balls in the random spot of the top area of the screen
	# Also makes them look differently each time
	add_child(ball)

func _on_banana_eaten():
	current_hunger+=25
	if current_hunger>=max_hunger:
		current_hunger=max_hunger
	hunger_bar.scale.y=current_hunger
	# Restore your hunger by eating bananas


func _on_ball_hit():
	current_happines+=10
	if current_happines>=max_happines:
		current_happines=max_happines
	happines_bar.scale.y=current_happines
	# Restore your happines by hiting balls
