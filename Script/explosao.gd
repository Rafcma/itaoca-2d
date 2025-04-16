extends Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	animation_player.play("som_explosao") 

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
