import 'package:flutter/material.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charityicon.dart';

class charityitem_body extends StatelessWidget {
  const charityitem_body({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          charityicon(),
          SizedBox(width: 10),
          Text("charity name", style: TextStyle(fontSize: 18)),
          SizedBox(width: 90),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_forward_ios_outlined),
          ),
        ],
      ),
    );
  }
}
