import 'package:flutter/material.dart';
import 'package:scp682/controllers/text_controllers.dart';
import 'package:scp682/data/utility.dart';
import 'package:scp682/pages/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

void pushHome(BuildContext context)async {
  var sh = await SharedPreferences.getInstance();
  sh.setString("phone", phoneController.text);
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
}