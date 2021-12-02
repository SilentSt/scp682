import 'package:flutter/cupertino.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {Key? key, required this.text, required this.fontSize, this.fontWeight = FontWeight.w400, this.textAlign = TextAlign
          .left, this.color=const Color(0xff000000)}) : super(key: key);
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: "Gotham",
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

}