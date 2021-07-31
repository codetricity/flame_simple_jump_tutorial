import 'package:flutter/material.dart';

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
