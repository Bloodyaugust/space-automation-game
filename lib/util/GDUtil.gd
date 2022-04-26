extends Node

static func centroid(points:Array) -> Vector2:
  var centroid:Vector2 = Vector2.ZERO

  if points.size() == 0:
    return centroid

  for _point in points:
    centroid += _point

  centroid = centroid / float(points.size())

  return centroid

static func free_children(node):
  for n in node.get_children():
      n.free()

static func get_files_in_directory(path:String) -> Array:
  var _dir:Directory = Directory.new()
  var _files:Array = []
  
  if _dir.open(path) == OK:
    _dir.list_dir_begin()
    var _file_name:String = _dir.get_next()
    while _file_name != "":
      if !_dir.current_is_dir():
        _files.append(_file_name)
      _file_name = _dir.get_next()
  
  return _files

static func queue_free_children(node):
  for n in node.get_children():
      n.queue_free()

static func reference_safe(node:Node) -> bool:
  return node != null && !node.is_queued_for_deletion() && is_instance_valid(node)

static func tilemap_global_cell_position(tilemap: TileMap, position: Vector2) -> Vector2:
  return tilemap.to_global(tilemap.map_to_world(tilemap.world_to_map(tilemap.to_local(position))))
