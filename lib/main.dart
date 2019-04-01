import 'package:boids/boidsGame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

main() async {
  Util util = Util();
  await util.fullScreen();
  await util.setOrientation(DeviceOrientation.portraitUp);
  BoidsGame game = BoidsGame(await util.initialDimensions());
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  runApp(game.widget);
  util.addGestureRecognizer(tapper);
}