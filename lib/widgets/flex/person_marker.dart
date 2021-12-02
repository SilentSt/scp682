import 'package:flutter/material.dart';
import 'package:scp682/data/utility.dart';
import 'package:scp682/widgets/flex/custom_text.dart';

class PersonMarker extends StatefulWidget {
  const PersonMarker(
      {Key? key,
      required this.userName,
      required this.battery,
      required this.img})
      : super(key: key);
  final String userName;
  final String battery;
  final Image img;

  @override
  _PersonMarkerState createState() => _PersonMarkerState();
}

class _PersonMarkerState extends State<PersonMarker> {
  @override
  Widget build(BuildContext context) {

    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: widget.img,
            onPressed: () {
              setState(() {});
            },
          ),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: const Color(0xa0ffffff),
                borderRadius: BorderRadius.circular(90)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                    text: widget.userName + " " + widget.battery + "%",
                    fontSize: 12),
                const Icon(Icons.battery_std)
              ],
            ),
          )
        ]);
  }
}
