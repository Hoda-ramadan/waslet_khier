import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';

class cstomfavRow2 extends StatelessWidget {
  const cstomfavRow2({super.key, required this.location});
  final String location;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            child: Text(
              "الجمعيات",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            context.push(location);
          },

          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: tintAppColor,
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              "الحالات",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
