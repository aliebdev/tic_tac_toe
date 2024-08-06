import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/pages/game_screen.dart';
import 'package:tic_tac_toe/providers/room_data_provider.dart';

import 'pages/create_room_page.dart';
import 'pages/join_room_page.dart';
import 'pages/main_menu_page.dart';
import 'utils/colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RoomDataProvider()),
      ],
      child: const MainApp(),
    ),
  );
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
        GameScreen.routeName: (context) => const GameScreen(),
      },
    );
  }
}
