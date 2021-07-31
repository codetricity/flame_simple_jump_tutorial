import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

class MainGame extends BaseGame {
  SpriteComponent background = SpriteComponent();
  SpriteComponent platform1 = SpriteComponent();
  SpriteComponent platform2 = SpriteComponent();
  SpriteComponent energyPowerUp = SpriteComponent();

  SpriteComponent girl = SpriteComponent();
  String direction = 'down';
  final spritePadding = 3;
  late final screenWidth;
  var fuel = 60;
  bool fuelConsumed = false;

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

    energyPowerUp
      ..sprite = await loadSprite('energy.webp')
      ..size = Vector2(80, 80)
      ..position = Vector2(300, 500)
      ..anchor = Anchor.center;
    add(energyPowerUp);

    girl
      ..sprite = await loadSprite('girl.png')
      ..size = Vector2(80, 80)
      ..position = Vector2(25, 100);
    add(girl);
  }

  bool onLeftPlatform() {
    return (girl.y + girl.height - spritePadding > platform1.y) &&
        (girl.x < platform1.x + platform1.width && direction != 'stop');
  }

  bool onRightPlatform() {
    // print('${girl.y + girl.height}, ${platform2.y}');
    // print('${girl.x + girl.width}, ${platform2.x}');
    // right platform
    return (girl.y + girl.height - spritePadding > platform2.y) &&
        (girl.y + girl.height < platform2.y + platform2.height) &&
        (girl.x + girl.width > platform2.x && direction != 'stop');
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (onLeftPlatform() || onRightPlatform()) {
      direction = 'stop';
    }
    if (direction == 'down') {
      girl.y += 30 * dt;
    }

    energyPowerUp.angle += .15 * dt;
    energyPowerUp.angle %= 2 * pi;

    if (girl.containsPoint(energyPowerUp.center)) {
      print('hit energy pill');
      energyPowerUp.remove();
      if (!fuelConsumed) {
        fuel += 30;
        fuelConsumed = true;
      }
    }
  }
}
