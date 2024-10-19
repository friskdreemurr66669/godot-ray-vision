@tool
extends Node2D

@export var gen := false
@export var destroy_children := false
@export_range(0, 180, 1) var range = 73
@export_range(0, 1000, 1) var rayrange = 1000
@export_range(0, 20, .1) var turn = .2

func _ready() -> void:
	gen = true

func _process(delta: float) -> void:
	if gen:
		gen = false
		
		kill_children()
		
		var rot = Node2D.new()
		add_child(rot)
		
		rot.rotation = deg_to_rad(range / -2 - 90)
		
		print(range/2)
		
		for i in ceil(range / turn) + 1:
			var inst = RayCast2D.new()
			add_child(inst)
			inst.global_transform = rot.global_transform
			rot.rotation += deg_to_rad(turn)
			inst.target_position.y = rayrange
	
	if destroy_children:
		destroy_children = false
		kill_children()

func kill_children() -> void:
	for i in get_child_count():
		get_child(i).queue_free()
