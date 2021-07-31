import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game_controller.dart';
import 'main_game.dart';

void main() {
  var game = MainGame();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            GameWidget(game: game),
            GameController(game: game),
          ],
        ),
      ),
    ),
  );
}
