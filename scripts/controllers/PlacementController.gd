extends Node2D

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
