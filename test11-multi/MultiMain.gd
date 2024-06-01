extends Node2D

var port = 6666

func _on_set_client_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_client($Address.get_text(), port)
	multiplayer.multiplayer_peer = peer
	print("set as client")

func _on_set_server_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(port, 5)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_player_connected)
	print("set as server")

func _on_player_connected(id):
	print("player " + str(id) + " connected")

func _on_send_pressed():
	received_message.rpc($TextEdit.get_text())

@rpc("any_peer", "reliable", "call_local")
func received_message(message):
	$Label.set_text(message)
