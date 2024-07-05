extends Node2D

@onready var commanders = get_children().filter(func(x): return x is Commander)
@onready var current: Commander = null:
	set(value):
		if current != null:
			current.active = false
		
		current = value
		
		if current != null:
			current.active = true
			
@export var current_index: int = 0:
	set(value):
		current_index = value % len(commanders)
		current = commanders[current_index]

func _ready():
	current_index = 0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	



func next():
	print("next")
	current_index += 1


func _on_button_pressed():
	next()
