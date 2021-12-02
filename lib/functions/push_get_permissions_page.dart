import 'package:flutter/material.dart';
import 'package:scp682/pages/pages.dart';

void pushPerms(BuildContext context) {
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const RegistrationGetPermissionsPage()));
}