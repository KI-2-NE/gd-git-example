class_name Trooper
extends Node2D

@onready var sprite = $sprite
@onready var team_sprite = $sprite/color
@onready var map = %map

@export var hovered := false:
	set(value):
		sprite.modulate = Color(2, 2, 2) if value else Color(1, 1, 1)
		hovered = value
		
@export var selected := false:
	set(value):
		selected = value
		update_ui()
		
@export var pos := Vector2(0, 0):
	set(value):
		pos = value
		position = map.map_to_local(pos)
		
		
var highlighted = []



func _ready():
	pos = pos # snap to initial pos
	
func command(coord):
	if coord in highlighted:
		pos = coord
		update_ui()

func update_ui():
	# selection
	if selected:
		map.clear_layer(1)
		map.set_cell(1, pos, 2, Vector2(0, 0))
		
		# highlight
		map.clear_layer(2)
		highlighted = generate_highlight(5, pos)
		for i in highlighted:
			map.set_cell(2, i, 2, Vector2(0, 0))
	else:
		map.clear_layer(1)
		map.clear_layer(2)
	
	
func generate_highlight(d, origin: Vector2i = pos, check = func(): return true):
	var generated = []
	spread_highlight(d, generated, origin, check)
	# safe to assume the first is 0, 0
	generated.remove_at(0)
	return generated

func spread_highlight(d, store, origin, check):
	if !check.call():
		return
	
	# self
	if origin not in store:
		store.append(origin)
	
	# recurse
	if d > 1:
		for cell_coord in map.get_surrounding_cells(origin):
			spread_highlight(d - 1, store, cell_coord, check)
		

func set_color(color: Color):
	team_sprite.modulate = color
