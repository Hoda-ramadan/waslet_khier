import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/charity_detels_view.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charityicon.dart';

class charityitem_body extends StatelessWidget {
  const charityitem_body({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          children: [
            charityicon(),

            SizedBox(width: 15),
            Text("مركز علاج الأورام بسوهاج", style: TextStyle(fontSize: 18)),
            SizedBox(width: 25),
            Spacer(),
            IconButton(
              onPressed: () {
                context.push("/charities/chaaritedetelies");
              },

              icon: Icon(Icons.arrow_forward_ios_outlined, color: tintAppColor),
            ),
          ],
        ),
      ),
    );
  }
}
