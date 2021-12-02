import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scp682/constants/colors.dart';
import 'package:scp682/functions/functions.dart';
import 'package:scp682/widgets/widgets.dart';
import 'package:scp682/controllers/text_controllers.dart';

class RegistrationPhonePage extends StatefulWidget {
  const RegistrationPhonePage({Key? key}) : super(key: key);

  @override
  State<RegistrationPhonePage> createState() => _RegistrationPhonePageState();
}

class _RegistrationPhonePageState extends State<RegistrationPhonePage> {
  Color buttonColor = lightGrey;
  Function buttonFunction = showErrorMessage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      home: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                  text: "Введите номер владельца телефона", fontSize: 20),
              const CustomText(
                  text:
                      "Номер будет доступен только близким людям. Он необходим для получения уведомлений и сигнала SOS",
                  fontSize: 15),
              TextField(
                decoration: const InputDecoration(
                  label: CustomText(
                    text: "Номер телефона",
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                keyboardType: TextInputType.phone,
                controller: phoneController,
                onChanged: (phone) {
                  RegExp exp = RegExp(
                      r'((8|\+7)-?)?\(?\d{3}\)?-?\d{1}-?\d{1}-?\d{1}-?\d{1}-?\d{1}-?\d{1}-?\d{1}-?\d{1}');
                  if (exp.hasMatch(phone) && phone.isNotEmpty) {
                    setState(() {
                      enableButton();
                    });
                  } else {
                    setState(() {
                      disableButton();
                    });
                  }
                },
              ),
              PushButton(
                widget: const CustomText(
                  text: "Продолжить",
                  fontSize: 18,
                  textAlign: TextAlign.center,
                ),
                function: buttonFunction,
                backgroundColor: buttonColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void enableButton() {
    buttonColor = blue;
    buttonFunction = pushSMS;
  }

  void disableButton() {
    buttonColor = lightGrey;
    buttonFunction = showErrorMessage;
  }
}
