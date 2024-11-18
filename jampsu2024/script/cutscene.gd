extends CanvasLayer
class_name Cutscene

static var current_cutscene := 0
const CUTSCENES := [
	"res://cutscene-niv1.tscn", 
	"res://scenes/UI/cutscene-niv1-5.tscn",
	"res://scenes/UI/cutscene-niv2.tscn",
	"res://scenes/UI/cutscene-niv2-5.tscn",
	"res://scenes/UI/cutscene-niv3.tscn",
	"res://cutscene-goodending.tscn"
]



static func load_cutscene() -> void:
	if current_cutscene >= CUTSCENES.size() or GlobalVariables.custscenes_played > current_cutscene:
		current_cutscene += 1
		return
	GlobalVariables.custscenes_played += 1
	GlobalVariables.world.add_child(load(CUTSCENES[current_cutscene]).instantiate())
	current_cutscene += 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer.volume_db = 0
	get_tree().paused = true
	$AnimationPlayer.play("defilement")
	$AnimationPlayer.speed_scale = 1 / $AudioStreamPlayer.stream.get_length()
	await $AnimationPlayer.animation_finished
	get_tree().paused = false
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		pass


func _on_button_pressed() -> void:
	$AudioStreamPlayer.pitch_scale += 1
	$AnimationPlayer.speed_scale += 1 / $AudioStreamPlayer.stream.get_length()


func _on_button_2_pressed() -> void:
	get_tree().paused = false
	queue_free()
