extends Node2D

@export var spawns: Array[Info_spawn] = []

@onready var player = get_tree().get_first_node_in_group("player")
@onready var ciclo_dia = get_tree().get_first_node_in_group("ciclo_dia")
@onready var inimigo_spawner: Node2D = $"."

var tempo = 0

signal muda_tempo(tempo)

func _ready() -> void:
	connect("muda_tempo", Callable(player, "muda_timer_jogo"))

func _on_timer_timeout():
	tempo += 1
	for i in spawns:
		if tempo >= i.inicio_tempo and tempo <= i.fim_tempo:
			if i.contador_tempo_spawn < i.inimigo_tempo_spawn:
				i.contador_tempo_spawn += 1
			else:
				i.inimigo_tempo_spawn = 0
				for n in i.inimigo_num:
					var inimigo = i.inimigo.instantiate()
					inimigo.global_position = get_random_position()
					add_child(inimigo)
					# Localiza luz do player
					var luz_player
					var player := get_tree().get_first_node_in_group("player")
					if player:
						for child in player.get_children():
							if child is PointLight2D:
								luz_player = child
								break

					# Aplica energia da luz do player ao inimigo
					if luz_player:
						for luz in inimigo_spawner.get_children():
							if luz is PointLight2D:
								luz.energy = luz_player.energy
								luz.visible = luz.energy > 0.01

	emit_signal("muda_tempo", tempo)


func get_random_position():
	var vpr = get_viewport_rect().size * randf_range(1.1, 1.4)
	var esquerda_superior = Vector2(player.global_position.x - vpr.x / 2, player.global_position.y - vpr.y / 2)
	var direita_superior = Vector2(player.global_position.x + vpr.x / 2, player.global_position.y - vpr.y / 2)
	var esquerda_inferior = Vector2(player.global_position.x - vpr.x / 2, player.global_position.y + vpr.y / 2)
	var direita_inferior = Vector2(player.global_position.x + vpr.x / 2, player.global_position.y + vpr.y / 2)
	var posicao_lado = ["cima", "baixo", "esquerda", "direita"].pick_random()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO

	match posicao_lado:
		"cima":
			spawn_pos1 = esquerda_superior
			spawn_pos2 = direita_superior
		"baixo":
			spawn_pos1 = esquerda_inferior
			spawn_pos2 = direita_inferior
		"direita":
			spawn_pos1 = direita_superior
			spawn_pos2 = direita_inferior
		"esquerda":
			spawn_pos1 = esquerda_superior
			spawn_pos2 = esquerda_inferior

	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	return Vector2(x_spawn, y_spawn)
