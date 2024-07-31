extends Area2D


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		$Collider.position = self.global_transform.basis_xform_inv(event.position)
		if $Collider.shape.collide($Collider.global_transform, $CollisionShape2D.get_shape(), $CollisionShape2D.global_transform):
			print("click detected")
			get_viewport().set_input_as_handled()
		else:
			print("NO click on the area")