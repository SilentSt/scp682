import 'package:flutter/material.dart';
import 'package:scp682/widgets/flex/custom_text.dart';
import 'package:scp682/widgets/flex/push_button.dart';

class QuitFamily extends StatelessWidget{
  const QuitFamily({Key? key}) : super(key: key);

  get out => null;

  get exit => null;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: CustomText(
        text: "Вы уверены, что хотите выйти из семьи?",
        fontSize: 15,

      ),
      content: Image.asset("/imgs/outF.png"),
      actions: [
        PushButton(widget: CustomText(text: "Остаться",fontSize: 15,), function: exit,),
        PushButton(widget: CustomText(text: "Да", fontSize: 15,), function: out)
      ],
    );
  }


}