import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resources/socket_methods.dart';

import '../responsive/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textfield.dart';

class JoinRoomPage extends StatefulWidget {
  static const String routeName = "/join-room";
  const JoinRoomPage({super.key});

  @override
  State<JoinRoomPage> createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends State<JoinRoomPage> {
  late TextEditingController _gameIdController;
  late TextEditingController _nameController;
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _gameIdController = TextEditingController();
    _nameController = TextEditingController();

    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccurredListener(context);
    _socketMethods.updatePlayerStateListener(context);
  }

  @override
  void dispose() {
    _gameIdController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                shadows: [
                  Shadow(
                    blurRadius: 40,
                    color: Colors.blue,
                  ),
                ],
                text: "Join Room",
                fontSize: 70,
              ),
              SizedBox(height: size.height * .08),
              CustomTextfield(
                controller: _nameController,
                hintText: "Enter your nickname",
              ),
              const SizedBox(height: 20),
              CustomTextfield(
                controller: _gameIdController,
                hintText: "Enter Game ID",
              ),
              SizedBox(height: size.height * .045),
              CustomButton(
                onPressed: () {
                  _socketMethods.joinRoom(
                    _nameController.text,
                    _gameIdController.text,
                  );
                },
                text: "Join",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
