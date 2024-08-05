import 'package:flutter/material.dart';

import 'pages/create_room_page.dart';
import 'pages/join_room_page.dart';
import 'pages/main_menu_page.dart';
import 'utils/colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        // ignore: deprecated_member_use
        useMaterial3: false,
      ),
      home: const MainMenuPage(),
      initialRoute: MainMenuPage.routeName,
      routes: {
        MainMenuPage.routeName: (context) => const MainMenuPage(),
        CreateRoomPage.routeName: (context) => const CreateRoomPage(),
        JoinRoomPage.routeName: (context) => const JoinRoomPage(),
      },
    );
  }
}
