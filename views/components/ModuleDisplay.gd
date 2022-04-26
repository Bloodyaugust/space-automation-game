extends Control

var data:ModuleData

@onready var _icon:TextureRect = $"./Icon"
@onready var _name:Label = $"./Name"

func _ready():
  _name.text = data.data.name
