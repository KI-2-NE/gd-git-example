class_name Trooper
extends Node2D

@onready var sprite = $sprite
@onready var map = %map

@export var hovered := false:
	set(value):
		sprite.modulate = Color(2, 2, 2) if value else Color(1, 1, 1)
		hovered = value
		
@export var selected := false:
	set(value):
		if value:
			map.set_cell(1, coord, 2, Vector2(0, 0))
			update_ui()
		else:
			map.clear_layer(1)
			map.clear_layer(2)
		
@export var coord := Vector2(0, 0):
	set(value):
		position = map.map_to_local(coord)
		coord = value
		
var highlighted = []



func _ready():
	coord = coord # snap to initial coord

func update_ui():
	spread_highlight(5)
	
func spread_highlight(d, origin = coord, check = func(): return true):
	if !check.call():
		return
	
	# self
	map.set_cell(2, origin, 2, Vector2(0, 0))
	
	# recurse
	if d > 1:
		for cell_coord in map.get_surrounding_cells(origin):
			spread_highlight(d - 1, cell_coord, check)
		
