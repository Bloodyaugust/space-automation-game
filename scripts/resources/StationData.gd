extends Resource
class_name StationData

@export var modules:Array
@export var station_name:String

func get_info() -> Dictionary:
  var cargo_capacity = 0
  var cargo_rate = 0
  var cost = {}
  var consumes = {}
  var generates = {}
  
  for _module in modules:
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
      
  return {
    "cargo_capacity": cargo_capacity,
    "cargo_rate": cargo_rate,
    "cost": cost,
    "consumes": consumes,
    "generates": generates,
  }
