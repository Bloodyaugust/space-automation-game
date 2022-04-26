extends Control

@onready var _load:Button = $"./HBoxContainer/Load"
@onready var _save:Button = $"./HBoxContainer/Save"
@onready var _stations:ItemList = $"./HBoxContainer/Stations"
@onready var _station_name:LineEdit = $"./HBoxContainer/StationName"

func _on_save_pressed() -> void:
  var _station_nodes = get_tree().get_nodes_in_group("stations")
  for _station in _station_nodes:
    _station.set_station_name(_station_name.text)
    _station.save_station()

func _ready():
  _save.connect("pressed", _on_save_pressed)
  
  var _station_files:Array = GDUtil.get_files_in_directory("user://stations/")
  var _station_resources:Array = []
  for _station_file in _station_files:
    var _resource:StationData = load("user://stations/" + _station_file)
    _stations.add_item(_resource.station_name)
