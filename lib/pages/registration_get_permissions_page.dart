import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scp682/constants/colors.dart';
import 'package:scp682/functions/functions.dart';
import 'package:scp682/functions/push_home_page.dart';
import 'package:scp682/widgets/widgets.dart';

class RegistrationGetPermissionsPage extends StatefulWidget {
  const RegistrationGetPermissionsPage({Key? key}) : super(key: key);

  @override
  State<RegistrationGetPermissionsPage> createState() =>
      _RegistrationGetPermissionsPageState();
}

class _RegistrationGetPermissionsPageState
    extends State<RegistrationGetPermissionsPage> {

  Color buttonColor = lightGrey;
  Function buttonFunction = showErrorMessage;
  AdvancedSwitch geoController = AdvancedSwitch();
  AdvancedSwitch pushController = AdvancedSwitch();
  @override
  void initState() {
    // geoController.addListener(() {
    //   setState(() {
    //     geoController.value&&pushController.value?enableButton():disableButton();
    //   });
    // });
    // pushController. addListener(() {
    //   setState(() {
    //     geoController.value&&pushController.value?enableButton():disableButton();
    //   });
    // });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child:
                      const CustomText(text: "Запрос доступа", fontSize: 20)),
              const SizedBox(
                height: 50,
              ),
              const CustomText(
                  text:
                      "Разрешения обеспечат максимальную точность работы приложения",
                  fontSize: 15),
              const SizedBox(
                height: 70,
              ),
              Column(
                children: [
                  Permisson(
                    description:
                        'Вы и ваши близкие смогут видеть историю ваших передвижений и текущее местонахождение',
                    iconLocalPath: 'imgs/location_perm.png',
                    label: 'Геолокация',
                    permisson: Permission.locationAlways, controller: geoController,
                  ),
                  const SizedBox(height: 50,),
                  Permisson(
                    description:
                    'Получение уведомлений даже при выключенном звуке и режиме «Не беспокоить»',
                    iconLocalPath: 'imgs/anounce.png',
                    label: 'Важные уведомления',
                    permisson: Permission.location,
                    controller: pushController,
                  ),
                  const SizedBox(height: 70,),
                  PushButton(widget: const CustomText(text: "Продолжить", fontSize: 18), function: buttonFunction, backgroundColor: buttonColor,),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  void enableButton()
  {
    buttonColor = blue;
    buttonFunction = pushHome;
  }

  void disableButton()
  {
    buttonColor = lightGrey;
    buttonFunction = showErrorMessage;
  }
}
