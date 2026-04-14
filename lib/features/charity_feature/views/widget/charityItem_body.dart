import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/charity_feature/views/charity_detels_view.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charityicon.dart';

class charityitem_body extends StatelessWidget {
  const charityitem_body({
    super.key,
    required this.charityModel,
    required this.icon,
    this.color,
  });
  final CharityModel charityModel;

  final IconData icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          children: [
            CharityIcon(charityimage: charityModel.logoUrl!),

            SizedBox(width: 15),
            Text(charityModel.name!, style: TextStyle(fontSize: 18)),
            SizedBox(width: 25),
            Spacer(),
            Container(
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
    );
  }
}
