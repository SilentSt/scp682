import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scp682/constants/colors.dart';
import 'package:scp682/controllers/text_controllers.dart';
import 'package:scp682/data/user.dart';
import 'package:scp682/data/utility.dart';
import 'package:scp682/functions/functions.dart';
import 'package:scp682/functions/push_create_family_page.dart';
import 'package:scp682/functions/push_get_permissions_page.dart';
import 'package:scp682/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegistrationFillingDataPage extends StatefulWidget {
  const RegistrationFillingDataPage({Key? key}) : super(key: key);

  @override
  State<RegistrationFillingDataPage> createState() =>
      _RegistrationFillingDataPageState();
}

class _RegistrationFillingDataPageState
    extends State<RegistrationFillingDataPage> {
  File? image;
  bool imagePicked = false;
  bool confPicked = false;
  Color buttonColor = lightGrey;
  Function buttonFunction = showErrorMessage;

  Future pickImage(ImageSource imgSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imgSource);
      if (image == null) return;
      final imageTemporary = File(image.path);
      User.img = Image.file(imageTemporary);
      User.strImg = await image.readAsBytes();
      setState(() {
        this.image = imageTemporary;
        imagePicked = true;
        if (confPicked && imagePicked && nameController.text.isNotEmpty) {
          enableButton();
        }
        else{
          disableButton();
        }
      });

    } on PlatformException catch (e) {
      //debugPrint(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: const CustomText(
                      fontSize: 20,
                      text: 'Обо мне',
                      textAlign: TextAlign.left,
                    )),
                const SizedBox(
                  height: 50,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: const CustomText(
                      fontSize: 15,
                      text: 'Имя будет отображаться на карте ',
                      textAlign: TextAlign.left,
                    )),
                const SizedBox(
                  height: 50,
                ),
                image != null
                    ? SizedBox(
                        width: 110,
                        height: 110,
                        child: IconButton(
                          onPressed: () {
                            pickImage(ImageSource.camera);
                          },
                          icon: ClipRRect(
                            borderRadius: BorderRadius.circular(90),
                            child: Image.file(
                              image!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            color: lightGrey),
                        child: IconButton(
                            onPressed: () {
                              pickImage(ImageSource.camera);
                            },
                            icon: Image.asset("imgs/camera.png"))),
                const SizedBox(
                  height: 50,
                ),
                TextField(
                  style: const TextStyle(
                      fontFamily: 'Gotham',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,),
                  onChanged: (text){
                    setState(() {
                      if (confPicked && imagePicked && nameController.text.isNotEmpty) {
                        enableButton();
                      }
                      else{
                        disableButton();
                      }
                    });
                  },
                  decoration: const InputDecoration(
                      label: CustomText(
                        text: "Имя",
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15)),
                  controller: nameController,
                ),
                const SizedBox(
                  height: 30,
                ),
                ChangeNotifierProvider(
                    create: (_) => CheckboxProvider(),
                    child: Consumer<CheckboxProvider>(
                      builder: (context, checkboxProvider, _) =>
                          CheckboxListTile(
                        value: checkboxProvider.isChecked,
                        onChanged: (value) {
                          setState(() {
                            checkboxProvider.isChecked = value ?? true;
                            confPicked = value ?? true;
                            if (confPicked && imagePicked && nameController.text.isNotEmpty) {
                              enableButton();
                            }
                            else{
                              disableButton();
                            }
                          });
                        },
                        activeColor: red,
                        title: const CustomText(
                          fontSize: 15,
                          text:
                              'Я принимаю условия политики конфиденциальности',
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    )),
                PushButton(
                  widget: const CustomText(
                    text: "Продолжить",
                    fontSize: 18,
                  ),
                  function: buttonFunction,
                  backgroundColor: buttonColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void enableButton()
  {
    buttonColor = blue;
    buttonFunction = pushCreateFamilyPage;
  }

  void disableButton()
  {
    buttonColor = lightGrey;
    buttonFunction = showErrorMessage;
  }
}

class CheckboxProvider with ChangeNotifier {
  bool _isChecked = false;

  bool get isChecked => _isChecked;

  set isChecked(bool value) {
    _isChecked = value;
    notifyListeners();
  }
}

