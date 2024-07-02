extends Node2D

@onready var map = %map

@export var selected_unit: Trooper = null:
	set(value):
		if selected_unit != null:
			selected_unit.selected = false
		if value != null:
			value.selected = true
		selected_unit = value
		
@export var units = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is Trooper:
			units.append(child)
	

func _input(event):	
	if event is InputEventMouse:
		var coord = map.local_to_map(get_global_mouse_position())
		var hovered_unit = get_unit_at(coord)
		
		for unit in units:
			unit.hovered = false
		if hovered_unit != null:
			hovered_unit.hovered = true
		
		# click
		if event is InputEventMouseButton and event.pressed and event.button_index == 1:
			if selected_unit == null:
				selected_unit = hovered_unit
			elif selected_unit == hovered_unit:
				selected_unit = null
			else:
				pass # idk
				
			print(selected_unit)
			
		
	

func get_unit_at(coord: Vector2) -> Trooper:
	for unit in units:
		if unit.coord == coord:
			return unit
	return null
	

		
