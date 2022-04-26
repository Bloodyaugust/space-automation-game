extends Node2D

@onready var _tilemap:TileMap = $"./TileMap"

var _station_data:StationData = StationData.new()

func add_node(node:Variant) -> void:
  _station_data.nodes.append(node)
  save_station()

func load_station(station_name:String) -> void:
  _station_data = load("user://stations/" + station_name + ".tres")

func save_station() -> void:
  print("Saving station: " + _station_data.station_name)
  ResourceSaver.save("user://stations/" + _station_data.station_name + ".tres", _station_data)

func set_station_name(station_name:String) -> void:
  _station_data.station_name = station_name
