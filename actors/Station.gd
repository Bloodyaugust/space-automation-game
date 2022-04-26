extends Node2D

@export var station_data_to_load:String

var data:StationData
var info:Dictionary

func _ready() -> void:
  if station_data_to_load:
    data = load("user://stations/" + station_data_to_load + ".tres")
  
  info = data.get_info()
  print(data.station_name)
  print(info.cargo_capacity)
