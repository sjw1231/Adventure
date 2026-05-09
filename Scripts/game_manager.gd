extends Node3D
class_name GameManager

static var instance: GameManager

@export var collected_items: Dictionary[String, int] = {
	'DIAMOND': 0,
	'COIN': 0,
	'CHERRY': 0,
}

@export var item_labels: Dictionary[String, Label]
@export var win_label: Label

var activated_checkpoints: Array[Checkpoint]
var is_complete: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass # Replace with function body.
	if instance == null:
		instance = self
	else:
		queue_free()
	
	win_label.visible = false
	print(win_label.visible)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func respawn_player(body: Node3D) -> void:
	#pass # Replace with function body.
	if body is CharacterBody3D:
		#get_tree().reload_current_scene()
		if len(activated_checkpoints) == 0:
			Player.instance.position = Player.instance.spawn_position
		else:
			var nearest_checkpoint = activated_checkpoints[-1]
			var nearest_dist = nearest_checkpoint.position.distance_squared_to(Player.instance.position)
			
			for ckpt in activated_checkpoints:
				var dist = ckpt.position.distance_squared_to(Player.instance.position)
				if dist < nearest_dist:
					nearest_checkpoint = ckpt
					nearest_dist = dist
			
			Player.instance.position = nearest_checkpoint.position + Vector3(0, 3, 0)

func collect_item(item_type):
	collected_items[item_type] += 1
	item_labels[item_type].text = str(collected_items[item_type])

func win_game():
	win_label.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	is_complete = true


func reload_scene() -> void:
	#pass # Replace with function body.
	get_tree().reload_current_scene()


func to_main_menu() -> void:
	#pass # Replace with function body.
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
