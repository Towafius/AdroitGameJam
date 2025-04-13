extends NavigationRegion2D

@export var max_coworkers = 1

@onready var spawn_points: Node2D = $SpawnPoints
@onready var coworkers: Node2D = $Coworkers
@onready var player: CharacterBody2D = $"../Player"

var spawn_points_list=[]


const COWORKER = preload("res://Scenes/Entities/Coworker/Coworker.tscn")
const JANITOR = preload("res://Scenes/Entities/Janitor/janitor.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in spawn_points.get_children():
		spawn_points_list.append(child)

func spawn_coworker():
	var new_coworker = COWORKER.instantiate()
	coworkers.add_child(new_coworker)
	var available_spawn_points = []
	for sp in spawn_points_list:
		if (sp.global_position.distance_to(player.global_position) >= 200):
			available_spawn_points.append(sp)
		else:
			print(sp)
	new_coworker.global_position = available_spawn_points.pick_random().global_position

func spawn_janitor():
	var jan = JANITOR.instantiate()
	self.add_child(jan)
	var available_spawn_points = []
	for sp in spawn_points_list:
		if (sp.global_position.distance_to(player.global_position) >= 200):
			available_spawn_points.append(sp)
		else:
			print(sp)
	jan.global_position = available_spawn_points.pick_random().global_position

func _on_coworker_spawn_timer_timeout() -> void:
	var number_coworkers := coworkers.get_child_count()
	if number_coworkers >= max_coworkers:
		return
	spawn_coworker()


func _on_coworker_limit_increase_timeout() -> void:
	max_coworkers+=1


func _on_janitor_spawner_timeout() -> void:
	spawn_janitor()
