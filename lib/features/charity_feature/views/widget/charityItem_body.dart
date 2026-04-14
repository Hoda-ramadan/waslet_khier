import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/charity_detels_view.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charityicon.dart';

class charityitem_body extends StatelessWidget {
  const charityitem_body({super.key, required this.icon, this.color});
  final IconData icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Expanded(
          child: Row(
            children: [
              charityicon(),

              SizedBox(width: 15),
              Text("مركز علاج الأورام بسوهاج", style: TextStyle(fontSize: 18)),
              SizedBox(width: 25),
              Spacer(),
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  onPressed: () {
                    context.push("/charities/chaaritedetelies");
                  },

                  icon: Icon(icon, color: color ?? tintAppColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
