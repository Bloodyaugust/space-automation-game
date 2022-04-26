extends Node2D

const MODULE_SCENE:PackedScene = preload("res://actors/Module.tscn")

@onready var _tilemap_indicator:Sprite2D = Sprite2D.new()

func _initialize() -> void:
  get_tree().get_root().add_child(_tilemap_indicator)

func _process(delta):
  var _station_tilemap:TileMap = get_tree().get_nodes_in_group("station_tilemap")[0]
  
  if _station_tilemap:
    var _mouse_position:Vector2 = get_global_mouse_position()

    _tilemap_indicator.global_position = GDUtil.tilemap_global_cell_position(_station_tilemap, _mouse_position)

func _ready():
  _tilemap_indicator.texture = load("res://icon.png")
  call_deferred("_initialize")

func _unhandled_input(event):
  if event.is_action_pressed("place-module"):
    var _station = get_tree().get_nodes_in_group("stations")[0]
    
    if _station && Store.state.selected_module:
      var _module_data:ModuleData = ModuleData.new()
      var _mouse_position:Vector2 = get_global_mouse_position()

      _module_data.data = Store.state.selected_module
      _module_data.position = GDUtil.tilemap_global_cell_position(_station._tilemap, _mouse_position)
      _station.add_module(_module_data)
