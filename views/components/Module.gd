extends Control

var module_data:ModuleDefinition

@onready var _icon:TextureRect = $"./Icon"
@onready var _name:Label = $"./Name"

func _gui_input(event):
  if event.is_action_pressed("place-module"):
    Store.set_state("selected_module", module_data)
    print("Selected module: " + module_data.name)

func _ready():
  _name.text = module_data.name
