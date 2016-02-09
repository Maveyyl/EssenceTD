
extends Node2D


func _ready():
	set_fixed_process(true)
	pass
	
func _fixed_process(delta):
	pass

func _draw():
	var wave_info_text = "Wave " + str(map.wave_started) + "/" + str(map.waves.size()) + "\n Monster count: " + str(map.monster_count)
	get_node("Node2D WaveInfo/Label Wave").set_text(wave_info_text)
	
	get_node("Node2D WaveInfo/Label Energy/Label EnergyCount").set_text( str(map.energy))
	





func _on_Button_NextWave_pressed():
	map.start_next_wave()

func _on_Button_Pause_pressed():
	OS.set_time_scale(0)

func _on_Button_Speed1_pressed():
	OS.set_time_scale(1)

func _on_Button_Speed2_pressed():
	OS.set_time_scale(2)

func _on_Button_Speed3_pressed():
	OS.set_time_scale(4)

func _on_Button_Speed8_pressed():
	OS.set_time_scale(8)

func _on_Button_Speed16_pressed():
	OS.set_time_scale(16)
