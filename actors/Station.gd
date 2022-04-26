extends Node2D

const MODULE_SCENE:PackedScene = preload("res://actors/Module.tscn")

@onready var _tilemap:TileMap = $"./TileMap"
@onready var _modules:Node2D = $"./Modules"

var _station_data:StationData = StationData.new()

func add_module(module:ModuleData) -> void:
  _station_data.modules.append(module)
  
  var _new_module = MODULE_SCENE.instantiate()
  _new_module.global_position = module.position
  _new_module.module_data = module
  _modules.add_child(_new_module)
  save_station()

func load_station(station_data:StationData) -> void:
  _station_data = station_data
  call_deferred("_after_data_loaded")

func save_station() -> void:
  print("Saving station: " + _station_data.station_name)
  ResourceSaver.save("user://stations/" + _station_data.station_name + ".tres", _station_data)

func set_station_name(station_name:String) -> void:
  _station_data.station_name = station_name

func _after_data_loaded() -> void:
  for _module in _station_data.modules:
    var _new_module = MODULE_SCENE.instantiate()
    _new_module.global_position = _module.position
    _modules.add_child(_new_module)
    print("Module: " + _module.data.name)
