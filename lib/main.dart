import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scp682/controllers/text_controllers.dart';
import 'package:scp682/requests/send_map_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'pages/pages.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneController.text = prefs.getString("phone")??'';
    nameController.text = prefs.getString("name")??'';
    //var r = await getUser(phoneController.text);
    //var res = r as http.Response;
    //var data = jsonDecode(res.body);
    //prefs.setString('familyID', data['familyID']);
    bool? _seen;

    _seen = (prefs.containsKey('phone') ?? false);

    if (_seen) {
      return "home";
    } else {
      // Set the flag to true at the end of onboarding screen if everything is successfull and so I am commenting it out
      // await prefs.setBool('seen', true);
      return "intro";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkFirstSeen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return MaterialApp(
              initialRoute: snapshot.data.toString(),
              routes: {
                "intro": (context) => OnBoardingPage(),
                "home": (context) => HomePage(),
              },
            );
          }
        });
  }
}
