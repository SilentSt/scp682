import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scp682/constants/colors.dart';
import 'package:scp682/controllers/text_controllers.dart';
import 'package:scp682/data/user.dart';
import 'package:scp682/widgets/flex/custom_text.dart';

class ProfileBottomSheet extends StatefulWidget {
  const ProfileBottomSheet({Key? key}) : super(key: key);

  @override
  State<ProfileBottomSheet> createState() => _ProfileBottomSheetState();
}

class _ProfileBottomSheetState extends State<ProfileBottomSheet> {

  File? image;
  bool imagePicked = false;
  bool confPicked = false;

  Future pickImage(ImageSource imgSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imgSource);
      if (image == null) return;
      final imageTemporary = File(image.path);
      User.img = Image.file(imageTemporary);
      setState(() {
        this.image = imageTemporary;
      });

    } on PlatformException catch (e) {
      //print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 110,
          height: 110,
          child: IconButton(
            onPressed: () {
              pickImage(ImageSource.camera);
            },
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: User.img,
            ),
          ),
        ),
        TextField(
          decoration: const InputDecoration(
            label: CustomText(text: "Имя", fontSize: 12, color: darkGrey,),
          ),
          controller: nameController,
        ),
        const SizedBox(height: 50,),
        TextField(
          decoration: const InputDecoration(
            label: CustomText(text: "Номер телефона", fontSize: 12, color: darkGrey,),
            border: InputBorder.none
          ),
          controller: phoneController,
          enabled: false,
        ),
        const SizedBox(height: 100,),
        const CustomTextButton(imgLink: "imgs/exit_fam.png", label: "Выйти из семьи", logDel: false,),
        const SizedBox(height: 50,),
        const CustomTextButton(imgLink: "imgs/delete_profile.png", label: "Удалить профиль", logDel: true,)
        // CustomText(text: "Номер телефона", fontSize: 12, color: darkGrey,)
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.imgLink,
    required this.label,
    required this.logDel,
  }) : super(key: key);

  final String imgLink;
  final String label;
  final bool logDel;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (){
          //logDel?debugPrint("delete"):debugPrint("logout");
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
