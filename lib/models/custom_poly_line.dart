import 'dart:ui';
import 'package:latlong2/latlong.dart';

class CustomPolyLine {
  List<LatLng> points=[];
  late final Color color;

  CustomPolyLine.fromJson(Map<dynamic, dynamic> json) {
    color = json['color'];
    var map = json['points'] as Map<double, double>;
    map.forEach((key, value) {
      points.add(LatLng(key, value));
    });
  }
  CustomPolyLine(this.points, this.color);
}
