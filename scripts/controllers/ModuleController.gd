extends Node2D

var modules:Array

func _ready():
  var _module_files = GDUtil.get_files_in_directory("res://data/modules/")
  for _file in _module_files:
    modules.append(load("res://data/modules/" + _file))
