extends CanvasLayer

@onready var velocity_label = $Velocity/VelocityLabel
@onready var time_left_label = $TimeLeft/TimeLeftLabel
@onready var fuel_bar = $FuelBar


func update_stats(velocity, time, fuel):
	velocity_label.text = str(-velocity)
	time_left_label.text = str(time).pad_decimals(2)
	fuel_bar.value = fuel
