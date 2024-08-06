import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resources/game_methods.dart';

void showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content)),
  );
}

void showGameDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text(text),
      actions: [
        TextButton(
          onPressed: () {
            GameMethods().clearBoard(context);
            Navigator.pop(context);
          },
          child: const Text("Play Again"),
        ),
      ],
    ),
  );
}
