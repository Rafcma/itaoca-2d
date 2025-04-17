extends ColorRect

@onready var lbl_nome = $lbl_nome
@onready var lbl_descricao = $lbl_descricao
@onready var lbl_nivel = $lbl_nivel
@onready var icone_item = $ColorRect/IconeItem

var mouse_encima = false
var item = null
@onready var player = get_tree().get_first_node_in_group("player")

signal upgrade_selecionado(upgrade)

func _ready() -> void:
	connect("upgrade_selecionado", Callable(player,"upgrade_personagem"))
	if item == null:
		item = "comida"
	lbl_nome.text = UpgradeDb.UPGRADES[item]["mostrarnome"]
	lbl_nivel.text = UpgradeDb.UPGRADES[item]["nivel"]
	lbl_descricao.text = UpgradeDb.UPGRADES[item]["detalhes"]
	icone_item.texture = load(UpgradeDb.UPGRADES[item]["icone"])

func _input(event: InputEvent) -> void:
	if event.is_action("click"):
		if mouse_encima:
			emit_signal("upgrade_selecionado", item)

func _on_mouse_entered() -> void:
	mouse_encima = true

func _on_mouse_exited() -> void:
	mouse_encima = false
