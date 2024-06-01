extends Node2D

var shader = load("res://test12-shader/Sprite2D.gdshader")

func _ready():
	$Sprite2D.material = ShaderMaterial.new()
	$Sprite2D.material.shader = shader



