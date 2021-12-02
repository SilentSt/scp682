import 'package:flutter/material.dart';
import 'package:scp682/pages/create_family_page.dart';

void pushCreateFamilyPage(BuildContext context) {
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const CreateFamilyPage()));
}