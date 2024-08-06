import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe/pages/game_screen.dart';
import 'package:tic_tac_toe/pages/main_menu_page.dart';
import 'package:tic_tac_toe/providers/room_data_provider.dart';
import 'package:tic_tac_toe/resources/game_methods.dart';
import 'package:tic_tac_toe/resources/socket_client.dart';
import 'package:tic_tac_toe/utils/util.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  // EMITS
  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
      });
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

  // LISTENERS
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on(
      'createRoomSuccess',
      (room) {
        print(room);
        context.read<RoomDataProvider>().updateRoomData(room);
        Navigator.pushNamed(context, GameScreen.routeName);
      },
    );
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on(
      'joinRoomSuccess',
      (room) {
        print(room);
        context.read<RoomDataProvider>().updateRoomData(room);
        Navigator.pushNamed(context, GameScreen.routeName);
      },
    );
  }

  void errorOccurredListener(BuildContext context) {
    _socketClient.on(
      'errorOccurred',
      (data) {
        showSnackbar(context, data);
      },
    );
  }

  void updatePlayerStateListener(BuildContext context) {
    _socketClient.on("updatePlayers", (playerData) {
      print("playerData = $playerData");
      context.read<RoomDataProvider>().updatePlayer1(playerData[0]);
      context.read<RoomDataProvider>().updatePlayer2(playerData[1]);
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on("updateRoom", (data) {
      context.read<RoomDataProvider>().updateRoomData(data);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on("tapped", (data) {
      context.read<RoomDataProvider>().updateDisplayElements(
            data['index'],
            data["choice"],
          );
      context.read<RoomDataProvider>().updateRoomData(data['room']);
      GameMethods().checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on("pointIncrease", (data) {
      final roomDataProvider = context.read<RoomDataProvider>();
      if (data['socketID'] == roomDataProvider.player1.socketID) {
        roomDataProvider.updatePlayer1(data);
      } else {
        roomDataProvider.updatePlayer2(data);
      }
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient.on("endGame", (data) {
      showGameDialog(context, "${data['nickname']} won the game!");
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainMenuPage.routeName,
        (route) => false,
      );
    });
  }
}
