import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

class User{
  static Image img = Image.asset("imgs/camera.png");
  static List<int>? strImg;
  static LatLng userGeo = LatLng(0,0);
  static bool? admin;
}