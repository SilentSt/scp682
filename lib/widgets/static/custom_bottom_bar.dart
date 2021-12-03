
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scp682/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:scp682/bottom_sheets/profile_bottom_sheet.dart';
import 'package:scp682/data/user.dart';

import 'package:scp682/widgets/flex/custom_text.dart';
import 'package:scp682/widgets/flex/push_button.dart';
import 'package:scp682/widgets/widgets.dart';


class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: darkGrey,
      selectedItemColor: darkGrey,
      iconSize: 30,
      showUnselectedLabels: true,
      currentIndex: 3,
      onTap: (index) {
        switch (index) {
          case 0:
            showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                builder: (BuildContext context) {
                  return Container(
                    height: MediaQuery.of(context).size.height - 80,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 60),
                    child: QrImage(
                      data: User.familyID??"ed0d7917-f457-41b1-b667-4288833f1af8",
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  );
                },
                context: context,
                isScrollControlled: true);
            break;

          case 1:
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                builder: (BuildContext context) {
                  return Container();
                },
                context: context,
                isScrollControlled: true);
            break;

          case 2:
            showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                builder: (BuildContext context) {
                  return Container(
                    height: MediaQuery.of(context).size.height - 80,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 60),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const CustomText(
                              text: "Помощь",
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          const PushButton(
                            widget: CustomText(
                              text: "  SOS  ",
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            function: sos,
                            backgroundColor: red,
                            shadowColor: darkGrey,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(
                                text: "Экстренные службы",
                                fontSize: 15,
                                color: darkGrey,
                              )),
                          const SizedBox(
                            height: 30,
                          ),
                          const PushButton(
                              widget: CustomText(text: "Полиция", fontSize: 20),
                              function: sos,
                              shadowColor: darkGrey,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 90, vertical: 18)),
                          const SizedBox(
                            height: 50,
                          ),
                          const PushButton(
                              widget: CustomText(
                                  text: "Скорая помощь", fontSize: 20),
                              function: sos,
                              shadowColor: darkGrey,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 55, vertical: 18)),
                          const SizedBox(
                            height: 50,
                          ),
                          const PushButton(
                              widget: CustomText(text: "112", fontSize: 20),
                              function: sos,
                              shadowColor: darkGrey,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 125, vertical: 18)),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                context: context,
                isScrollControlled: true);
            break;

          case 3:
            showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.all(30),
                    height: MediaQuery.of(context).size.height - 100,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          CustomTextButton(
                            imgLink: "imgs/location_perm.png",
                            label: "Места",
                            child: ProfileBottomSheet(),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          CustomTextButton(
                              imgLink: "imgs/user.png",
                              label: "Данные пользователя",
                              child: ProfileBottomSheet()),
                          SizedBox(
                            height: 30,
                          ),
                          CustomTextButton(
                              imgLink: "imgs/perms.png",
                              label: "Разрешения",
                              child: ProfileBottomSheet()),
                          SizedBox(
                            height: 30,
                          ),
                          CustomTextButton(
                              imgLink: "imgs/bell.png",
                              label: "Уведомления",
                              child: ProfileBottomSheet()),
                          SizedBox(
                            height: 30,
                          ),
                          CustomTextButton(
                              imgLink: "imgs/happy.png",
                              label: "Поддержка",
                              child: ProfileBottomSheet()),
                          SizedBox(
                            height: 10,
                          ),
                          Outfuck(imglink: "imgs/Sign_out_circle.png", label: "Выйти из приложения")
                          ///ADD EXIT BUTTON
                        ],
                      ),
                    ),
                  );
                },
                context: context,
                isScrollControlled: true);
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
            icon: Image.asset("imgs/fam.png"), label: "Семья"),
        BottomNavigationBarItem(
            icon: Image.asset("imgs/places.png"), label: "Места"),
        BottomNavigationBarItem(
            icon: Image.asset("imgs/sos.png"), label: "SOS"),
        BottomNavigationBarItem(
            icon: Image.asset("imgs/settings.png"), label: "Настройки")
      ],
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.imgLink,
    required this.label,
    required this.child,
  }) : super(key: key);

  final String imgLink;
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (){
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              builder: (BuildContext context) {
                return Container(
                  padding: const EdgeInsets.all(30),
                  height: MediaQuery.of(context).size.height - 100,
                  child: SingleChildScrollView(
                      child: child
                  ),
                );
              },
              context: context,
              isScrollControlled: true);
        },
        style: ButtonStyle(
          overlayColor:
              MaterialStateColor.resolveWith((states) => Colors.transparent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(imgLink),
            CustomText(text: label, fontSize: 15),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            )
          ],
        ));
  }
}

void sos(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Image.asset("imgs/sos_on.png")),
                const SizedBox(
                  height: 30,
                ),
                const CustomText(
                  text: "Режим SOS включится\nчерез 5 секунд!",
                  fontSize: 20,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      text: "Ваши близкие получат уведомление",
                      fontSize: 15,
                      color: darkGrey,
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "imgs/location_perm.png",
                      color: red,
                    ),
                    const CustomText(
                        text: "переулок Журавлева 102", fontSize: 15)
                  ],
                )
              ],
            )
          ],
        );
      });
}


class Outfuck extends StatelessWidget{
  const Outfuck({
    Key? key,
    required this.imglink,
    required this.label,
}) : super(key: key);

  final String imglink;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (){},
        style: ButtonStyle(
          overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(imglink),
            CustomText(text: label, fontSize: 15,color: Colors.red,),
            const SizedBox(width: 10,)
          ],
        ));
  }



}