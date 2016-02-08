extends Node

# everything here MUST be constant



var scripts= {
	"MapData" : load("res://src/MapData.gd"),
	"MonsterData" : load("res://src/MonsterData.gd"),
	"WaveData" : load("res://src/WaveData.gd"),
	"tile" : load("res://src/tile.gd"),
	"wave" : load("res://src/wave.gd")	
}
	
var objects_data= {
	"maps":{
		"scenes": [
			load("res://resources/scenes/maps/map1.scn")
		]
	},
	"tiles":{
		"name_by_index":[
			"water",
			"grass",
			"path",
			"base"
		],
		"index_by_name":{
			"water": 0,
			"grass": 1,
			"path": 2,
			"base": 3
		},
		"passible_tiles": [
			false,
			false,
			true,
			true
		]
	},
	"essences":{
		"name_by_index":[
			"empty",
			"fire",
			"water",
			"earth",
			"air"
		],
		"index_by_name":{
			"empty": 0,
			"fire": 1,
			"water": 2,
			"earth": 3,
			"air": 4
		},
		"scenes":[
			load("res://resources/scenes/essences/essence.scn"),
			load("res://resources/scenes/essences/fire_essence.scn"),
			load("res://resources/scenes/essences/water_essence.scn"),
			load("res://resources/scenes/essences/earth_essence.scn"),
			load("res://resources/scenes/essences/air_essence.scn")
		]
	},
	"bullets":{
		"scenes":[
			load("res://resources/scenes/bullets/bullet.scn")
		]
	},
	"monsters":{
		"name_by_index":[
			"monster",
			"normal",
			"tank",
			"swarm",
			"speed"
		],
		"index_by_name":{
			"monster":0,
			"normal":1,
			"tank":2,
			"swarm":3,
			"speed":4
		},
		"scenes":[
			load("res://resources/scenes/monsters/monster.scn"),
			load("res://resources/scenes/monsters/normal_monster.scn"),
			load("res://resources/scenes/monsters/tank_monster.scn"),
			load("res://resources/scenes/monsters/swarm_monster.scn"),
			load("res://resources/scenes/monsters/speed_monster.scn")
		]
	},
	"buildings":{
		"name_by_index":[
			"tower"
		],
		"index_by_name":{
			"tower": 0,
		},
		"scenes":[
			load("res://resources/scenes/buildings/tower.scn")
		]
	}
}
