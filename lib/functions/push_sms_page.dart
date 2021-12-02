import 'package:flutter/material.dart';
import 'package:scp682/pages/registration_sms_page.dart';

void pushSMS(BuildContext context) async{
  Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const RegistrationSmsPage()));
}