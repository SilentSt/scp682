import 'package:flutter/material.dart';
import 'package:scp682/widgets/flex/custom_text.dart';

void showErrorMessage(BuildContext context) {
  showDialog(context: context, builder: (context){
    return const AlertDialog(
      title: CustomText(fontSize: 20,text: "Вы заполнили не все поля",),
    );
  });
}