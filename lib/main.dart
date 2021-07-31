import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  var game = MyGame();
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

class GameController extends StatefulWidget {
  final game;
  const GameController({Key? key, required this.game}) : super(key: key);

  @override
  _GameControllerState createState() => _GameControllerState();
}

class _GameControllerState extends State<GameController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 120,
          alignment: Alignment.bottomRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('assets/images/jetpack_small.png'),
              Text(
                widget.game.fuel.toString(),
                style: TextStyle(fontSize: 80),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              iconSize: 64,
              icon: Icon(Icons.arrow_back_rounded),
              onPressed: () {
                if (widget.game.fuel > 0) {
                  widget.game.girl.x = widget.game.girl.x - 10;
                  widget.game.girl.y = widget.game.girl.y - 10;
                  widget.game.direction = 'down';
                  setState(() {
                    widget.game.fuel -= 1;
                  });
                }
                widget.game.girl.renderFlipX = true;

                print('left boost. fuel: ${widget.game.fuel}');
              },
            ),
            IconButton(
              iconSize: 64,
              icon: Icon(Icons.arrow_forward_rounded),
              onPressed: () {
                if (widget.game.fuel > 0) {
                  widget.game.girl.x = widget.game.girl.x + 10;
                  widget.game.girl.y = widget.game.girl.y - 10;
                  widget.game.direction = 'down';
                  setState(() {
                    widget.game.fuel -= 1;
                    widget.game.girl.renderFlipX = false;
                  });
                }
                print('right boost. fuel: ${widget.game.fuel}');
              },
            ),
          ],
        ),
      ],
    );
  }
}

class MyGame extends BaseGame {
  SpriteComponent background = SpriteComponent();
  SpriteComponent platform1 = SpriteComponent();
  SpriteComponent platform2 = SpriteComponent();

  SpriteComponent girl = SpriteComponent();
  String direction = 'down';
  final spritePadding = 3;
  late final screenWidth;
  var fuel = 60;

  Future<void> onLoad() async {
    screenWidth = size[0];
    background
      ..sprite = await loadSprite('background.png')
      ..size = size
      ..position = Vector2(0, 0);
    add(background);

    platform1
      ..sprite = await loadSprite('platform.png')
      ..size = Vector2(100, 50)
      ..position = Vector2(0, 600);
    add(platform1);

    platform2
      ..sprite = await loadSprite('platform.png')
      ..size = Vector2(100, 50)
      ..position = Vector2(screenWidth - 100, 300);
    add(platform2);

    girl
      ..sprite = await loadSprite('girl.png')
      ..size = Vector2(80, 80)
      ..position = Vector2(25, 100);
    add(girl);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // left platform
    if ((girl.y + girl.height - spritePadding > platform1.y) &&
        (girl.x < platform1.x + platform1.width && direction != 'stop')) {
      direction = 'stop';
    }
    // print('${girl.y + girl.height}, ${platform2.y}');
    // print('${girl.x + girl.width}, ${platform2.x}');
    // right platform
    if ((girl.y + girl.height - spritePadding > platform2.y) &&
        (girl.x + girl.width > platform2.x && direction != 'stop')) {
      direction = 'stop';
    }
    if (direction == 'down') {
      girl.y += 30 * dt;
    }
  }
}
