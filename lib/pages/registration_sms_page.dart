import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scp682/functions/functions.dart';
import 'package:scp682/widgets/flex/custom_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:sms_autofill/sms_autofill.dart';

class RegistrationSmsPage extends StatefulWidget {
  const RegistrationSmsPage({Key? key}) : super(key: key);

  @override
  State<RegistrationSmsPage> createState() => _RegistrationSmsPageState();
}

class _RegistrationSmsPageState extends State<RegistrationSmsPage> {
  @override
  Widget build(BuildContext context) {
    String _code = "";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Scaffold(
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
        body: Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: const CustomText(
                    text: "Код из SMS",
                    fontSize: 20,
                    textAlign: TextAlign.left,
                  )),

              const CustomText(
                  text:
                      "На номер отправлен код. Пожалуйста, введите его для подтверждения",
                  fontSize: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: PinFieldAutoFill(
                  codeLength: 4,
                  decoration: UnderlineDecoration(
                    textStyle:
                        const TextStyle(fontSize: 20, color: Colors.black),
                    colorBuilder:
                        FixedColorBuilder(Colors.black.withOpacity(0.3)),
                  ),
                  currentCode: _code,
                  onCodeSubmitted: (code) {
                      pushData(context);
                  },

                ),
              ),

              GestureDetector(
                onTap: (){},
                  child: const CustomText(
                      text: "Запросить код повторно", fontSize: 15))
            ],
          ),
        ),
      ),
    );
  }
}
