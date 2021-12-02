import 'dart:ui';
import 'package:latlong2/latlong.dart';

class UserModel {
  String? name;
  String? phone;
  List<int>? photo;
  String? familyID;
  bool? admin;

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    photo = json['photo'];
    familyID = json['familyID'];
    admin = json['admin'];
  }
  UserModel.toJson(Map<dynamic, dynamic> map)
  {

  }
}
