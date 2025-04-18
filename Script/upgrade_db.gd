extends Node

const ICONE_PATH = "res://Textures/Items/Upgrades/"
const ARMAS_PATH = "res://Textures/Items/Weapons/"
const UPGRADES = {
	"lancadegelo1": {
		"icone": ARMAS_PATH + "ice_spear.png",
		"mostrarnome": "Lança de Gelo",
		"detalhes": "Uma lança de gelo é arremessada em um inimigo aleatório.",
		"nivel": "Nível: 1",
		"prerequisito": [],
		"tipo": "arma"
	},
	"lancadegelo2": {
		"icone": ARMAS_PATH + "ice_spear.png",
		"mostrarnome": "Lança de Gelo",
		"detalhes": "Uma Lança de Gelo adicional é arremessada.",
		"nivel": "Nível: 2",
		"prerequisito": ["lancadegelo1"],
		"tipo": "arma"
	},
	"lancadegelo3": {
		"icone": ARMAS_PATH + "ice_spear.png",
		"mostrarnome": "Lança de Gelo",
		"detalhes": "Lanças de Gelo agora atravessam outro inimigo e causam +3 de dano.",
		"nivel": "Nível: 3",
		"prerequisito": ["lancadegelo2"],
		"tipo": "arma"
	},
	"lancadegelo4": {
		"icone": ARMAS_PATH + "ice_spear.png",
		"mostrarnome": "Lança de Gelo",
		"detalhes": "Mais 2 Lanças de Gelo adicionais são arremessadas.",
		"nivel": "Nível: 4",
		"prerequisito": ["lancadegelo3"],
		"tipo": "arma"
	},
	"javelin1": {
		"icone": ARMAS_PATH + "javelin_3_new_attack.png",
		"mostrarnome": "Javelin",
		"detalhes": "Um javelin mágico seguirá você atacando inimigos em linha reta.",
		"nivel": "Nível: 1",
		"prerequisito": [],
		"tipo": "arma"
	},
	"javelin2": {
		"icone": ARMAS_PATH + "javelin_3_new_attack.png",
		"mostrarnome": "Javelin",
		"detalhes": "O javelin agora atacará um inimigo adicional por ataque.",
		"nivel": "Nível: 2",
		"prerequisito": ["javelin1"],
		"tipo": "arma"
	},
	"javelin3": {
		"icone": ARMAS_PATH + "javelin_3_new_attack.png",
		"mostrarnome": "Javelin",
		"detalhes": "O javelin atacará outro inimigo adicional por ataque.",
		"nivel": "Nível: 3",
		"prerequisito": ["javelin2"],
		"tipo": "arma"
	},
	"javelin4": {
		"icone": ARMAS_PATH + "javelin_3_new_attack.png",
		"mostrarnome": "Javelin",
		"detalhes": "O javelin agora causa +5 de dano por ataque e causa 20% de repulsão adicional.",
		"nivel": "Nível: 4",
		"prerequisito": ["javelin3"],
		"tipo": "arma"
	},
	"tornado1": {
		"icone": ARMAS_PATH + "tornado.png",
		"mostrarnome": "Tornado",
		"detalhes": "Um tornado é criado e se move aleatoriamente na direção do jogador.",
		"nivel": "Nível: 1",
		"prerequisito": [],
		"tipo": "arma"
	},
	"tornado2": {
		"icone": ARMAS_PATH + "tornado.png",
		"mostrarnome": "Tornado",
		"detalhes": "Um Tornado adicional é criado.",
		"nivel": "Nível: 2",
		"prerequisito": ["tornado1"],
		"tipo": "arma"
	},
	"tornado3": {
		"icone": ARMAS_PATH + "tornado.png",
		"mostrarnome": "Tornado",
		"detalhes": "O tempo de recarga do Tornado é reduzido em 0.5 segundos.",
		"nivel": "Nível: 3",
		"prerequisito": ["tornado2"],
		"tipo": "arma"
	},
	"tornado4": {
		"icone": ARMAS_PATH + "tornado.png",
		"mostrarnome": "Tornado",
		"detalhes": "Um tornado adicional é criado e a repulsão é aumentada em 25%.",
		"nivel": "Nível: 4",
		"prerequisito": ["tornado3"],
		"tipo": "arma"
	},
	"armadura1": {
		"icone": ICONE_PATH + "helmet_1.png",
		"mostrarnome": "Armadura",
		"detalhes": "Reduz o Dano em 1 ponto.",
		"nivel": "Nível: 1",
		"prerequisito": [],
		"tipo": "melhoria"
	},
	"armadura2": {
		"icone": ICONE_PATH + "helmet_1.png",
		"mostrarnome": "Armadura",
		"detalhes": "Reduz o Dano em mais 1 ponto.",
		"nivel": "Nível: 2",
		"prerequisito": ["armadura1"],
		"tipo": "melhoria"
	},
	"armadura3": {
		"icone": ICONE_PATH + "helmet_1.png",
		"mostrarnome": "Armadura",
		"detalhes": "Reduz o Dano em mais 1 ponto.",
		"nivel": "Nível: 3",
		"prerequisito": ["armadura2"],
		"tipo": "melhoria"
	},
	"armadura4": {
		"icone": ICONE_PATH + "helmet_1.png",
		"mostrarnome": "Armadura",
		"detalhes": "Reduz o Dano em mais 1 ponto.",
		"nivel": "Nível: 4",
		"prerequisito": ["armadura3"],
		"tipo": "melhoria"
	},
	"velocidade1": {
		"icone": ICONE_PATH + "boots_4_green.png",
		"mostrarnome": "Velocidade",
		"detalhes": "Velocidade de Movimento aumentada em 50% da velocidade base.",
		"nivel": "Nível: 1",
		"prerequisito": [],
		"tipo": "melhoria"
	},
	"velocidade2": {
		"icone": ICONE_PATH + "boots_4_green.png",
		"mostrarnome": "Velocidade",
		"detalhes": "Velocidade de Movimento aumentada em mais 50% da velocidade base.",
		"nivel": "Nível: 2",
		"prerequisito": ["velocidade1"],
		"tipo": "melhoria"
	},
	"velocidade3": {
		"icone": ICONE_PATH + "boots_4_green.png",
		"mostrarnome": "Velocidade",
		"detalhes": "Velocidade de Movimento aumentada em mais 50% da velocidade base.",
		"nivel": "Nível: 3",
		"prerequisito": ["velocidade2"],
		"tipo": "melhoria"
	},
	"velocidade4": {
		"icone": ICONE_PATH + "boots_4_green.png",
		"mostrarnome": "Velocidade",
		"detalhes": "Velocidade de Movimento aumentada em mais 50% da velocidade base.",
		"nivel": "Nível: 4",
		"prerequisito": ["velocidade3"],
		"tipo": "melhoria"
	},
	"tomo1": {
		"icone": ICONE_PATH + "thick_new.png",
		"mostrarnome": "Tomo",
		"detalhes": "Aumenta o tamanho dos feitiços em mais 10% do seu tamanho base.",
		"nivel": "Nível: 1",
		"prerequisito": [],
		"tipo": "melhoria"
	},
	"tomo2": {
		"icone": ICONE_PATH + "thick_new.png",
		"mostrarnome": "Tomo",
		"detalhes": "Aumenta o tamanho dos feitiços em mais 10% do seu tamanho base.",
		"nivel": "Nível: 2",
		"prerequisito": ["tomo1"],
		"tipo": "melhoria"
	},
	"tomo3": {
		"icone": ICONE_PATH + "thick_new.png",
		"mostrarnome": "Tomo",
		"detalhes": "Aumenta o tamanho dos feitiços em mais 10% do seu tamanho base.",
		"nivel": "Nível: 3",
		"prerequisito": ["tomo2"],
		"tipo": "melhoria"
	},
	"tomo4": {
		"icone": ICONE_PATH + "thick_new.png",
		"mostrarnome": "Tomo",
		"detalhes": "Aumenta o tamanho dos feitiços em mais 10% do seu tamanho base.",
		"nivel": "Nível: 4",
		"prerequisito": ["tomo3"],
		"tipo": "melhoria"
	},
	"pergaminho1": {
		"icone": ICONE_PATH + "scroll_old.png",
		"mostrarnome": "Pergaminho",
		"detalhes": "Diminui o tempo de recarga dos feitiços em mais 5% do seu tempo base.",
		"nivel": "Nível: 1",
		"prerequisito": [],
		"tipo": "melhoria"
	},
	"pergaminho2": {
		"icone": ICONE_PATH + "scroll_old.png",
		"mostrarnome": "Pergaminho",
		"detalhes": "Diminui o tempo de recarga dos feitiços em mais 5% do seu tempo base.",
		"nivel": "Nível: 2",
		"prerequisito": ["pergaminho1"],
		"tipo": "melhoria"
	},
	"pergaminho3": {
		"icone": ICONE_PATH + "scroll_old.png",
		"mostrarnome": "Pergaminho",
		"detalhes": "Diminui o tempo de recarga dos feitiços em mais 5% do seu tempo base.",
		"nivel": "Nível: 3",
		"prerequisito": ["pergaminho2"],
		"tipo": "melhoria"
	},
	"pergaminho4": {
		"icone": ICONE_PATH + "scroll_old.png",
		"mostrarnome": "Pergaminho",
		"detalhes": "Diminui o tempo de recarga dos feitiços em mais 5% do seu tempo base.",
		"nivel": "Nível: 4",
		"prerequisito": ["pergaminho3"],
		"tipo": "melhoria"
	},
	"anel1": {
		"icone": ICONE_PATH + "urand_mage.png",
		"mostrarnome": "Anel",
		"detalhes": "Seus feitiços agora geram mais 1 ataque adicional.",
		"nivel": "Nível: 1",
		"prerequisito": [],
		"tipo": "melhoria"
	},
	"anel2": {
		"icone": ICONE_PATH + "urand_mage.png",
		"mostrarnome": "Anel",
		"detalhes": "Seus feitiços agora geram um ataque adicional.",
		"nivel": "Nível: 2",
		"prerequisito": ["anel1"],
		"tipo": "melhoria"
	},
	"comida": {
		"icone": ICONE_PATH + "chunk.png",
		"mostrarnome": "Comida",
		"detalhes": "Cura você em 20 de vida.",
		"nivel": "N/A",
		"prerequisito": [],
		"tipo": "item"
	}
}
