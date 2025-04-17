extends Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var som_explosao: AudioStreamPlayer2D = $som_explosao

func _ready():
	som_explosao.play()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
