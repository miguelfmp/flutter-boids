import 'dart:ui';
import 'package:vector_math/vector_math.dart';
import 'package:boids/boidsGame.dart';

class Boid {
  final BoidsGame game;
  Vector2 position; Vector2 velocity;
  Rect boidRect; Paint boidPaint;
  List<Boid> _neighbours = List<Boid>();
  int _thinkTimer = 0;

  Boid(this.game, double xx, double yy) {
    position = Vector2(xx, yy);
    velocity = Vector2(0, 0);
    boidRect = Rect.fromLTWH(xx, yy, game.tileSize, game.tileSize);
    boidPaint = Paint();
    boidPaint.color = Color(0xffff5100);
  }

  void render(Canvas c) => c.drawRect(boidRect, boidPaint);

  void update(double t) {
    increment();
    checkBounds();
    if (_thinkTimer == 0) getNeighbours();
    flock();
    boidRect = boidRect.translate(velocity.x, velocity.y);
    position = Vector2(boidRect.center.dx, boidRect.center.dy);
  }

  void flock() {
    Vector2 noise = Vector2.random() * 2 - Vector2(1, 1);
    velocity += getAllRules() + (getObstaclesAvoid() * 15) + (noise * 0.25);
    velocity.length = 2.0;
  }

  void getNeighbours() {
    if (game.boids == null) return;
    _neighbours.clear();
    game.boids.forEach((boid) {
      if (boid != this) {
        if (boid.position.distanceTo(position).abs() < 50) {
          _neighbours.add(boid);
        }
      }
    });
  }

  Vector2 getObstaclesAvoid() {
    Vector2 steer = Vector2(0, 0);
    game.obstacles.forEach((obstacle) {
      double distance = position.distanceTo(obstacle.position);
      if (distance > 0 && distance < 100) { steer.add((position - obstacle.position).normalized() / distance); }
    });
    return steer;
  }

  Vector2 getAllRules() {
    Vector2 allignmentSum = Vector2.zero();
    Vector2 separationSteer = Vector2.zero();
    Vector2 cohesionSum = Vector2.zero();
    double count = 0;
    _neighbours.forEach((neighbour) {
      double distance = position.distanceTo(neighbour.position);
      if (distance > 0) {
        if (distance < 50) {
          allignmentSum.add(neighbour.velocity.gg.normalized() / distance);
          cohesionSum.add(neighbour.position); 
          count++;
        }
        if (distance < 25) separationSteer.add((this.position - neighbour.position).normalized() / distance);
      }
    });
    count > 0
        ? (cohesionSum = (cohesionSum / count) - position).length = 0.01
        : cohesionSum = Vector2.zero();
    return allignmentSum + separationSteer + cohesionSum;
  }

  void increment() =>_thinkTimer = (_thinkTimer + 1) % 5;

  void checkBounds() => boidRect = Rect.fromLTWH((boidRect.left + game.sw) % game.sw,(boidRect.top + game.sh) % game.sh, game.tileSize, game.tileSize);
}
