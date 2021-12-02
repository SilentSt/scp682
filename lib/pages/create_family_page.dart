import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scp682/constants/colors.dart';
import 'package:scp682/controllers/text_controllers.dart';
import 'package:scp682/data/user.dart';
import 'package:scp682/functions/push_home_page.dart';
import 'package:scp682/headers/headers.dart';
import 'package:scp682/pages/qr_scanner_page.dart';
import 'package:scp682/requests/send_map_data.dart';
import 'package:scp682/widgets/flex/custom_text.dart';
import 'package:scp682/widgets/flex/push_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateFamilyPage extends StatefulWidget {
  const CreateFamilyPage({Key? key}) : super(key: key);

  @override
  State<CreateFamilyPage> createState() => _CreateFamilyPageState();
}

class _CreateFamilyPageState extends State<CreateFamilyPage> {
  final qrKey = const Key("QR");
  QRViewController? qrController;

  @override
  void dispose() {
    qrController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CustomText(
                  text:
                      "Соберите членов своей семьи самостотельно или присоединитесь к существующей группе",
                  fontSize: 20),
              Image.asset("imgs/create_fam.png"),
              PushButton(
                widget: const CustomText(
                  text: "Присоединиться",
                  fontSize: 18,
                  color: Colors.white,
                ),
                function: scanQRCode,
                backgroundColor: blue,
              ),
              TextButton(
                  onPressed: () => regUser(),

                  ///HERE ADD CREATING FAMILY
                  child: const CustomText(
                    text: "Пропустить",
                    fontSize: 18,
                    color: darkGrey,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void scanQRCode(BuildContext context) async {
    Map<String, dynamic> data = {};
    data['name'] = nameController.text;
    data['phone'] = phoneController.text;
    data['photo'] = base64Encode(User.strImg!);
    data['admin'] = false;
    data['familyID'] = 'f0d757dc-43cf-4af2-a148-49e95becd633';
    var r = await sendMapDataWithoutHeaders("user/user", data, registrationHeaders);
    var res = r as http.Response;
    if(res.statusCode==200)
      {
        var sh = await SharedPreferences.getInstance();
        var famID = jsonDecode(res.body)['familyID'];
        sh.setString("familyID", famID);
      }
    else if(res.statusCode==201)
      {
        var sh = await SharedPreferences.getInstance();
        var famID = jsonDecode(res.body)['familyID'];
        var name = jsonDecode(res.body)['name'];
        var phone= jsonDecode(res.body)['phone'];
        var photo= jsonDecode(res.body)['photo'];
        var admin= jsonDecode(res.body)['admin'];
        nameController.text = name;
        phoneController.text = phone;
        User.strImg = photo;
        User.admin = admin;
        sh.setBool('admin', admin??false);
        sh.setString('phone', phone??'');
        sh.setString("familyID", famID??'');
      }
    pushHome(context);
  }

  void regUser() async {
    Map<String, dynamic> data = {};
    data['name'] = nameController.text;
    data['phone'] = phoneController.text;
    //data['photo'] = base64Encode(User.strImg!);
    data['admin'] = true;
    var r = await sendMapDataWithoutHeaders("user/user", data, registrationHeaders);
    var res = r as http.Response;
    print(res.body);
    if(res.statusCode ==200)
      {
        var sh = await SharedPreferences.getInstance();
        var famID = jsonDecode(res.body)['familyID'];
        sh.setString("familyID", famID);
        pushHome(context);
      }
    else if(res.statusCode == 201)
      {
        var sh = await SharedPreferences.getInstance();
        var famID = jsonDecode(res.body)['familyID'];
        var name = jsonDecode(res.body)['name'];
        var phone= jsonDecode(res.body)['phone'];
        var photo= jsonDecode(res.body)['photo'];
        var admin= jsonDecode(res.body)['admin'];
        nameController.text = name;
        phoneController.text = phone;
        User.strImg = photo;
        User.admin = admin;
        sh.setBool('admin', admin);
        sh.setString('phone', phone);
        sh.setString("familyID", famID);
      }

  }
}
