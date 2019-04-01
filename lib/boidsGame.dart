import 'dart:ui';
import 'package:boids/boid.dart';
import 'package:boids/obstacle.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';

class BoidsGame extends Game {
  final Size screenSize;
  List<Boid> boids = List<Boid>(); 
  List<Obstacle> obstacles = List<Obstacle>();
  double tileSize, sw, sh;

  BoidsGame(this.screenSize) {
    tileSize = screenSize.width / 100;
    sw = screenSize.width;
    sh = screenSize.height;
    spawnObstacle(sw*0.25, sh*0.20);
    spawnObstacle(sw*0.65, sh*0.20);
    spawnObstacle(sw*0.25, sh*0.75);
    spawnObstacle(sw*0.65, sh*0.75);
    spawnBoid(0, 0);
  }

  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff30302f);
    canvas.drawRect(bgRect, bgPaint);
    boids.forEach((Boid boid) => boid.render(canvas));
    obstacles.forEach((Obstacle obstacle) => obstacle.render(canvas));
  }

  void update(double t) => boids.forEach((Boid boid) => boid.update(t));
  void onTapDown(TapDownDetails d) => spawnBoid(d.globalPosition.dx, d.globalPosition.dy);
  void spawnBoid(double xx, double yy) => boids.add(Boid(this, xx, yy));
  void spawnObstacle(double xx, double yy) => obstacles.add(Obstacle(xx, yy));
}