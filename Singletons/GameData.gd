extends Node

var scene_data = {
	"CreditsScreen": {
		"parentscene": "MainMenu"
	}
}

var tower_data = {
	"GunT1": {
		"damage": 20,
		"rof": 1,
		"range": 350,
		"category": "HitScan",
		"barrelcount": 1,
		"price": 100},
	"MissileT1": {
		"damage": 60,
		"rof": 3,
		"range": 550,
		"category": "Projectile",
		"barrelcount": 2,
		"price": 200},
	"MachineGunT1": {
		"damage": 6,
		"rof": .25,
		"range": 250,
		"category": "HitScan",
		"barrelcount": 2,
		"price": 150}
	}
	

var enemy_data = {
	"WoodCrate": {
		"hp": 200,
		"reward": 100,
		"type": "crate"},
	"SteelCrate": {
		"hp": 500,
		"reward": 250,
		"type": "crate"},	
	"SandTank": {
		"hp": 50,
		"speed": 150,
		"damage": 20,
		"reward": 10,
		"type": "tank"},
	"RedTank": {
		"hp": 100,
		"speed": 100,
		"damage": 30,
		"reward": 20,
		"type": "tank"}
	}

