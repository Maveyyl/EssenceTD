# EssenceTD
EssenceTD is a Tower Defense 2D game developed using Godot.<br>
Like other Tower Defenses the main principle is to prevent monsters from reaching your base.<br>
It is partly inspired from Gem craft series.<br>

## Specifications
### Game Objects

#### Map Tile
The map tiles are what constitute a map, they are divided in 4 category: Base tile, path tile, constructible tile and non constructible tiles.<br>
The Base tile is what must be protected, it's always linked to at least one path tile.<br>
Paths are where monsters can walk.<br>
Constructible tiles are where buildings can be constructed. Simple as that.<br>

##### Tile type
- base : not constructible
- grass : impassible
- water : not constructible, impassible
- path : walls and traps can be constructed

#### Map
The main view of the game is filled with the Map. It's a 2D tiled map and the camera is set to look at it from above.<br>
When a map is loaded, paths between entry points and the base are computed and remembered.<br>

#### Monsters
Monsters are the enemies, they come in waves and have different characteristics from one wave to another.<br>

##### Monster characteristics
- type : monster type, change appearance and base characteristics
- damage : damage dealt to the base when reached
- movement_speed : how much pixel the monster travels per second
- health_point_max : maximum amount of health point, when health point reach 0, the monster dies
- healing_speed : amount of health recovered per second
- armor_max : maximum amount of armor point, armor reduces income damage by 100 / (100+armor)
- reward : the rewarded Energy when killed

##### Monster types
- normal
- speed : increased movement speed (x1.5)
- swarm : increased monster count per wave (x2), decreased resilience (x0.75)
- tank : increased resilience (x2), lowered monster count and speed (x0.5)

#### Waves
Waves are group of monsters. A map has a given count of wave. Each wave contains the same type of monster with the same characteristics. During a game, waves gets gradually tougher.<br>
When a wave is "started", it'll step by step spawn monsters. When all monsters are spawned the wave is "completed". When all monsters are killed the wave is "annihilated".<br>

##### Wave characteristics
- monster data : the characteristics of the monsters that are contained in the wave
- monster count : count of monster in the wave
- spawn time : time between the spawn of two monsters of the wave

#### Buildings
Buildings are the main defense structure against the monsters. Buildings can't do anything by themselves they are sockets for essences.<br>

##### Building types
- Towers : cannot be built on paths, do not influence essence's characteristics
- Traps : must be built on paths, essences locked in have short range, lower damage and higher reloading speed and special power
- Walls : paths with a wall become impassible terrain for monsters, there must be a path to the base from each entry

#### Essences
Essences are orbs of elemental power. They have different elemental types and using them as weapon against monsters imply different types of special effects. There are 4 base elements for essences and they can be fused to make different elements. There is a total of 14 elements and as much unique special effects.<br>
Essences can also be combined to add their special effects. For example an ice essence's attack will stun a single monster targeted, when combined with a fire essence then the attacks will stun and damage the monsters around the target.<br>
There is a lot of different combinations.<br>

##### Essence characteristics
- essence type : the elemental type of the essence
- damage : the raw damage the essence deals per hit
- reload_time : the number of second necessary for the essence to reload and fire again			
- range : the maximal fire range of the essence
- special power : how powerful will be the essence special effects
- kill_count : the amount of monsters killed
- consecutive_hit : the amount of hit on the same target
- level : the level of the essence
- behavior : the way the essence will prioritize targets

##### Essence types
- earth : 		bouncing projectile special effect
- air : 		flat armor reduction special effect
- water : 		beam special effect
- fire : 		splash damage special effect

- ice :			(water + air)				stun special effect
- magma	:		(earth + fire)				flat damage over time special effect
- lightning	:	(fire + air)				multi hit special effect
- vapor	:		(fire + water)				energy gathering special effect
- sand :		(earth + air)				vulnerability
- mud :			(earth + water)				slow

- darkness :	(water + fire + earth)		scaling damage over time special effect
- light	:		(air + fire + earth)		scaling armor reduction special effect
- life :		(water + air + earth)		growing stats on focus special effect
- death	:		(water + fire + air)		growing stats on kill special effect

##### Special effects in detail
- splash :						hits inflict damage and effects on monsters at max special_power distance around the hit
- bouncing :					hits bounce on ceil(0.1*special_power) nearby units	
- flat armor reduction :		reduce armor for 0.01*special_power per hit
- Beam :						reload_time decreased (1+0.01*special_power) times

- multi hit : 					frac(special_power)/trunc(0.01*special_power+1) + 1-(1/ trunc(0.01*special_power+1) ) chance of dealing trunc(0.01*special_power+1) the essence's damage
- flat DOT :					inflicts special_power*damage in 3 second
- stun :						frac(0.01*special_power)/trunc(0.01*special_power+1) + 1-(1/ trunc(0.01*special_power+1) ) chance of stun for trunc(0.01*special_power+1) seconds
- energy gathering :			steals special_power energy per hit
- vulnerability :				Each hit sets a stack of vulnerability, every hit of other towers will break one stack and deal 0.01*special_power more damage
- slow :						max slow 80%, slowed for (1 - ( 100/(100+special_power) )*0.8, add on hit, duration is 3 second

- growing stats on focus :		increases damage for 1+(0.01*special_power) per hit on the same target
- growing stats on kill :		increases damage definitively for 1+(0.001*special_power) per kill
- scaling DOT :					inflicts 0.001*special_power % of the targets life in damage
- scaling armor reduction :		reduces armor by 0.01*special_power % of targets armor, stackable per essence, not per hit, applies before flat armor reduction


##### Essence targeting behaviors
- Closest
- Farthest
- Most armored
- Most resilient
- Least armored
- Least resilient
- Most damage
- Least damage
- Random target until it is dead
- Random target per hit
- Selected target

##### Essence fusion
Fuse two essence into a new essence if fused elements can make a new one.<br>
The new essence will have characteristics based on the average (trunc for integer characteristics) of the fused elements.
The fusion will automatically level up the new essence.<br>
Example: if former essences were level 5 and 5, the average level will be 5, and leveled up 6.<br>
If former essences were level 2 and 5, the average level will be 3 (trunc from 3.5), and leveled up to 4.<br>

##### Essence combination
Does the same as fusion but isn't final. Does the average of the characteristics but does not have a result level.
All special effects and special power characteristics are kept.<br>
Special power is divided by the number of the essences in proportion of their essence level.<br>
Example: level 5 fire essence with 50 special power is combined with level 1 water essence with 10 special power.
Results will have 41 (50*5/(5+1)) special power in fire and 1.6 (10*1/(5+1)) special power in water.<br>



## TODO
### Core Features
- Energy system, with costs on essences and buildings, and rewards on killing monsters
- Design traps and implement
- More building designs
- Implement levels on essence
- Implement behavior on essence
- Design and implement essence fusions
- Implement ice essence and stun special effect
- Implement magma essence and flat DOT special effect
- Implement lightning essence and multi hit special effect
- Implement vapor essence and energy gathering special effect
- Implement sand essence and vulnerability special effect
- Implement mud essence and slow special effect
- Implement darkness essence and scaling DOT special effect
- Implement light essence and scaling armor reduction special effect
- Implement life essence and growing stats on focus special effect
- Implement death essence and growing stats on kill special effect
- Implement walls, WARNING walls will heavily use the pathfinding algorithm.
- Design and implement essence combination
- Limit to amount of drawn monsters and projectiles

### Interfaces, tools and views
- Building build buttons
- Energy bar
- Info pop-up with characteristics and costs when hovering a button or selecting a map entity
- Wave progression bar or something similar (design to do)
- Start menu with map selection
- Options menu

### Graphics
- Everything is ugly and to be redesigned

### Code refactor, organization and structure
- Place the armor damage reduction calculation and monster type's characteristic tweak into global

### Improvements
- Balancing!!!
- Make smaller tiles while not changing building's size and monster size, allowing more detailed map and paths for monsters. WARNING will make pathfinding algorithm heavier.
- Make monster's move seem more natural (when they turn an edge?)
- Random module giving more random things, basically used for path choosing and monster type generation.

## Feature ideas and undecided designs  
- Buildings could have experience or could be upgraded
- Combining essence effects could be done with specific buildings.
- Combining essence effects could be done thanks to an empty essence that will have sockets in it (upgrade to have more sockets)
- Energy pump buildings: putting an essence on a energy pump building can pump energy from the environment. For example a water tower on water tile.
- Map maker