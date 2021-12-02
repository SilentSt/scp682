import 'package:flutter/material.dart';
import 'package:scp682/pages/pages.dart';

void pushData(BuildContext context) {
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const RegistrationFillingDataPage()));
}