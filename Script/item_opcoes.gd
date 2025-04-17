extends ColorRect

var mouse_encima = false
var item = null
@onready var player = get_tree().get_first_node_in_group("player")

signal upgrade_selecionado(upgrade)

func _ready() -> void:
	connect("upgrade_selecionado", Callable(player,"upgrade_personagem"))
	
func _input(event: InputEvent) -> void:
	if event.is_action("click"):
		if mouse_encima:
			emit_signal("upgrade_selecionado", item)
	

func _on_mouse_entered() -> void:
	mouse_encima = true

func _on_mouse_exited() -> void:
	mouse_encima = false
