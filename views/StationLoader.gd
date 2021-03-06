extends Control

const MODULE_COMPONENT:PackedScene = preload("res://views/components/Module.tscn")
const STATION_SCENE:PackedScene = preload("res://actors/StationLayout.tscn")

@onready var _load:Button = $"./HBoxContainer/Load"
@onready var _modules:GridContainer = $"./HBoxContainer/Modules"
@onready var _save:Button = $"./HBoxContainer/Save"
@onready var _stations:ItemList = $"./HBoxContainer/Stations"
@onready var _station_name:LineEdit = $"./HBoxContainer/StationName"

var _station_resources:Dictionary = {}
var _selected_station_item:String

func _load_stations() -> void:
  var _station_files:Array = GDUtil.get_files_in_directory("user://stations/")

  _stations.clear()
  _station_resources = {}

  for _station_file in _station_files:
    var _resource:StationData = load("user://stations/" + _station_file)
    _station_resources[_resource.station_name] = _resource
    _stations.add_item(_resource.station_name)

func _on_load_pressed() -> void:
  if _selected_station_item:
    var _station_nodes = get_tree().get_nodes_in_group("station_layouts")
    for _station in _station_nodes:
      _station.queue_free()

    var _new_station:Node2D = STATION_SCENE.instantiate()
    _new_station.load_station(_station_resources[_selected_station_item])
    get_tree().get_root().add_child(_new_station)
    
    _station_name.text = _station_resources[_selected_station_item].station_name
    
    await _new_station.station_loaded
    Store.set_state("selected_station", _new_station)

func _on_save_pressed() -> void:
  var _station_nodes = get_tree().get_nodes_in_group("station_layouts")
  for _station in _station_nodes:
    _station.set_station_name(_station_name.text)
    _station.save_station()
    
  _load_stations()

func _on_stations_item_selected(item:int) -> void:
  _selected_station_item = _stations.get_item_text(item)

func _populate_modules() -> void:
  for _module in ModuleController.modules:
    var _new_module_component = MODULE_COMPONENT.instantiate()
    
    _new_module_component.module_data = _module
    _modules.add_child(_new_module_component)

func _ready():
  _load.connect("pressed", _on_load_pressed)
  _save.connect("pressed", _on_save_pressed)
  _stations.connect("item_selected", _on_stations_item_selected)
  
  _load_stations()
  call_deferred("_populate_modules")
