extends TextureRect

var upgrade = null

func _ready() -> void:
	if upgrade != null:
		$ItemTextura.texture = load(UpgradeDb.UPGRADES[upgrade]["icone"])
