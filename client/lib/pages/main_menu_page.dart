import 'package:flutter/material.dart';

import '../responsive/responsive.dart';
import '../widgets/custom_button.dart';
import 'create_room_page.dart';
import 'join_room_page.dart';

class MainMenuPage extends StatelessWidget {
  static const String routeName = "/main-menu";
  const MainMenuPage({super.key});

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomPage.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                onPressed: () => createRoom(context),
                text: "Create Room",
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () => joinRoom(context),
                text: "Join Room",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
