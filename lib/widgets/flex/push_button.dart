import 'package:flutter/material.dart';
import 'package:scp682/constants/constants.dart';

class PushButton extends StatelessWidget {
  const PushButton(
      {Key? key,
      required this.widget,
      required this.function,
      this.backgroundColor = lightGrey,
      this.padding = const EdgeInsets.symmetric(horizontal: 50, vertical: 18), this.shadowColor=Colors.transparent})
      : super(key: key);
  final Widget widget;
  final Function function;
  final Color backgroundColor;
  final EdgeInsets padding;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
        onPressed: () => function(context),
        child: Padding(
          padding: padding,
          child: widget,
        ),
        style: ButtonStyle(
          elevation: shadowColor!=Colors.transparent?MaterialStateProperty.all(5):MaterialStateProperty.all(0),
          shadowColor: MaterialStateProperty.all(shadowColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
        ),
      ),
    );
  }
}
