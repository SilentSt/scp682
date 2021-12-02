import 'dart:ui';
import 'package:latlong2/latlong.dart';

class CustomPolygon {
  List<LatLng> points=[];
  late final Color color;

  CustomPolygon.fromJson(Map<dynamic, dynamic> json) {
    color = json['color'];
    var map = json['points'] as Map<double, double>;
    map.forEach((key, value) {
      points.add(LatLng(key, value));
    });
  }

  CustomPolygon(this.points, this.color);
}
