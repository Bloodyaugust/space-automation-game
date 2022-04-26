extends Control

const MODULE_DISPLAY_COMPONENT:PackedScene = preload("res://views/components/ModuleDisplay.tscn")

@onready var _name:Label = $"./MarginContainer/HBoxContainer/Name"
@onready var _cargo:Label = $"./MarginContainer/HBoxContainer/Stats/Cargo"
@onready var _energy:Label = $"./MarginContainer/HBoxContainer/Stats/Energy"
@onready var _module_count:Label = $"./MarginContainer/HBoxContainer/Stats/ModuleCount"
@onready var _modules:HBoxContainer = $"./MarginContainer/HBoxContainer/ScrollContainer/Modules"

func _on_store_state_changed(state_key:String, substate) -> void:
  match state_key:
    "selected_station":
      _update_info(substate)
      if substate:
        substate.station_updated.connect(_update_info)

func _ready():
  Store.state_changed.connect(_on_store_state_changed)
  
func _update_info(station) -> void:
  GDUtil.queue_free_children(_modules)

  if station:
    _name.text = station._station_data.station_name
    _cargo.text = "cargo: {capacity} ({rate})".format({
      "capacity": station.cargo_capacity,
      "rate": station.cargo_rate,
    })
    _energy.text = "energy: {generated}/{consumed}".format({
      "generated": station.generates.energy,
      "consumed": station.consumes.energy,
    })
    _module_count.text = "modules: {module_count}".format({
      "module_count": station._station_data.modules.size(),
    })
    
    for _module in station._station_data.modules:
      var _new_module_component:Control = MODULE_DISPLAY_COMPONENT.instantiate()
      
      _new_module_component.data = _module
      _modules.add_child(_new_module_component)
