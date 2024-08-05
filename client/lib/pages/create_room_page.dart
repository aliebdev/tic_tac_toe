import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resources/socket_methods.dart';

import '../responsive/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textfield.dart';

class CreateRoomPage extends StatefulWidget {
  static const String routeName = "/create-room";
  const CreateRoomPage({super.key});

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  late TextEditingController _nameController;
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _socketMethods.createRoomSuccessListener(context);
  }

  @override
  void dispose() {
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
                text: "Create Room",
                fontSize: 70,
              ),
              SizedBox(height: size.height * .08),
              CustomTextfield(
                controller: _nameController,
                hintText: "Enter your nickname",
              ),
              SizedBox(height: size.height * .045),
              CustomButton(
                onPressed: () =>
                    _socketMethods.createRoom(_nameController.text),
                text: "Create",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
