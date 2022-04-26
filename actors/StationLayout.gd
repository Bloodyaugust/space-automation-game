extends Node2D

signal station_loaded(station)
signal station_updated(station)

const MODULE_SCENE:PackedScene = preload("res://actors/Module.tscn")

var cargo_capacity:float
var cargo_rate:float
var cost:Dictionary
var consumes:Dictionary
var generates:Dictionary

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
  _update_stats()
  emit_signal("station_updated", self)

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
      
  _update_stats()
  emit_signal("station_loaded", self)

func _update_stats() -> void:
  cargo_capacity = 0
  cargo_rate = 0
  cost = {}
  consumes = {}
  generates = {}

  for _module in _station_data.modules:
    cargo_capacity += _module.data.cargo_capacity
    cargo_rate += _module.data.cargo_rate
    
    for _key in _module.data.cost.keys():
      if !cost.has(_key):
        cost[_key] = 0
        
      cost[_key] += _module.data.cost[_key]
    
    for _key in _module.data.consumes.keys():
      if !consumes.has(_key):
        consumes[_key] = 0
        
      consumes[_key] += _module.data.consumes[_key]
    
    for _key in _module.data.generates.keys():
      if !generates.has(_key):
        generates[_key] = 0
        
      generates[_key] += _module.data.generates[_key]
