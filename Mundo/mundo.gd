extends Node2D

@export var cena_poste: PackedScene  # Aponte para poste.tscn no inspetor

@onready var player: CharacterBody2D = $Player
var poste_instanciado: Node2D
var poste_sprite: Sprite2D

func _ready():
	# Instancia o poste da cena poste.tscn
	poste_instanciado = cena_poste.instantiate()
	poste_instanciado.global_position = Vector2(400, 400)  # ajuste a posição conforme o necessário
	add_child(poste_instanciado)

	poste_sprite = poste_instanciado.get_node("Sprite2D")
