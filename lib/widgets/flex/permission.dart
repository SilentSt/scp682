import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scp682/constants/colors.dart';
import 'package:scp682/widgets/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class Permisson extends StatelessWidget {
  const Permisson({
    Key? key, required this.iconLocalPath, required this.label, required this.description, required this.permisson, required this.controller,
  }) : super(key: key);

  final String iconLocalPath;
  final String label;
  final String description;
  final PermissionWithService permisson;
  final AdvancedSwitchController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(iconLocalPath),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: label,
              fontSize: 15,
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 200,
              child: CustomText(
                text: description,
                fontSize: 15,
                color: darkGrey,
              ),
            )
          ],
        ),
        ChangeNotifierProvider(
            create: (_) => SwitchProvider(),
            child: Consumer<SwitchProvider>(
              builder: (context, checkboxProvider, _) => AdvancedSwitch(
                controller: controller,
                activeColor: blue,

              ),
            )),
      ],
    );
  }
}

class SwitchProvider with ChangeNotifier {
  bool _isChecked = false;

  bool get isChecked => _isChecked;

  set isChecked(bool value) {
    _isChecked = value;
    notifyListeners();
  }
}