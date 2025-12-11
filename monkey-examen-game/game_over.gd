extends CanvasLayer

func _ready() -> void:
	get_tree().paused=true
	# Pauses the game when this screen pops up

func _on_restart_pressed() -> void:
	get_tree().paused=false
	get_tree().reload_current_scene()
	#Restarts the game
	
