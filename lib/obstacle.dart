import 'dart:ui';
import 'package:vector_math/vector_math.dart';

class Obstacle {
  Vector2 position; 
  Rect rect;
  Paint paint;
  Obstacle(double x, double y) {
    position = Vector2(x, y);
    rect = Rect.fromLTWH(x, y, 25, 25);
    paint = Paint();
    paint.color = Color(0xff737373);
  }
  void render(Canvas c) => c.drawRect(rect, paint);
}
