extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var grupo_postes: Node = $Postes

func _process(_delta):
	# +1000 evita que o player fique atrás do chão
	player.z_index = int(player.global_position.y) + 1000

	for poste in grupo_postes.get_children():
		if poste.has_node("Sprite2D"):
			var sprite = poste.get_node("Sprite2D")
			sprite.z_index = int(poste.global_position.y) + 1000
