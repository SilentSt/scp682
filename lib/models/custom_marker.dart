import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class CustomMarker{
  late final String userName;
  late final String batteryPercent;
  late final Image img;
  late final LatLng latLng;
  CustomMarker.fromJson(Map<dynamic, dynamic> json)
  {
    userName = json['userName'];
    batteryPercent = json['batteryPercent'];
    img = json['img'];
    latLng = json['latLng'];
  }
  CustomMarker(this.userName, this.img, this.latLng, this.batteryPercent);

}