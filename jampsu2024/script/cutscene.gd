extends CanvasLayer

const CUTSCENES := [
	"res://cutscene-niv1.tscn", 
	"res://scenes/UI/cutscene-niv1-5.tscn",
	"res://scenes/UI/cutscene-niv2.tscn",
	"res://scenes/UI/cutscene-niv2-5.tscn",
	"res://scenes/UI/cutscene-niv3.tscn",
	"res://cutscene-goodending.tscn"
	
]




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
