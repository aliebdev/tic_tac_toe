import 'package:flutter/material.dart';
import 'package:tic_tac_toe/pages/game_screen.dart';
import 'package:tic_tac_toe/resources/socket_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
      });
    }
  }

  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on(
      'createRoomSuccess',
      (room) {
        print(room);
        Navigator.pushNamed(context, GameScreen.routeName);
      },
    );
  }
}
