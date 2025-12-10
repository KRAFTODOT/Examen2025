extends Node2D

@onready var sound: AudioStreamPlayer = %Sound
@onready var banana_button: Button = %"Banana button"
@onready var ball_button: Button = %"Ball button"
@onready var left_top_marker: Marker2D = %"Left-top"
@onready var right_bottom_marker: Marker2D = %"Right-bottom"

var left_top
var right_bottom

const BALL = preload("uid://b674ep5cr4ocn")
const BANANA = preload("uid://ce8jf405bkf03")

func _ready() -> void:
	left_top=left_top_marker.position
	right_bottom=right_bottom_marker.position
	
func _on_banana_button_pressed() -> void:
	var x=randi_range(left_top.x,right_bottom.x)
	var y=randi_range(left_top.y,right_bottom.y)
	var banana=BANANA.instantiate()
	banana.position=Vector2(x,y)
	add_child(banana)


func _on_ball_button_pressed() -> void:
	var x=randi_range(left_top.x,right_bottom.x)
	var y=randi_range(left_top.y,right_bottom.y)
	var ball=BALL.instantiate()
	ball.position=Vector2(x,y)
	add_child(ball)
