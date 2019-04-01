import 'package:boids/boidsGame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

main() async {
  Util flameUtil = Util();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  BoidsGame game = new BoidsGame();
  TapGestureRecognizer tapper =TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  runApp(game.widget);
  flameUtil.addGestureRecognizer(tapper);
}