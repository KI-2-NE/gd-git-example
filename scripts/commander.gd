class_name Commander
extends Node2D

@onready var map = %map
@onready var turner = %turner

@export var selected_unit: Trooper = null:
	set(value):
		if selected_unit != null:
			selected_unit.selected = false
		if value != null:
			value.selected = true
		selected_unit = value
		
@export var units = []

@export var active := false:
	set(value):
		active = value
		if not active:
			selected_unit = null
			
@export_color_no_alpha var team_color := Color.WHITE

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is Trooper:
			child.set_color(team_color)
			units.append(child)
	

func _input(event):
	if not active:
		return
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
				selected_unit.command(coord)
			
		
	

func get_unit_at(coord: Vector2) -> Trooper:
	for unit in units:
		if unit.pos == coord:
			return unit
	return null
	
