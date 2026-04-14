import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/charity_feature/views/charity_detels_view.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charityicon.dart';

class charityitem_body extends StatelessWidget {
<<<<<<< HEAD
<<<<<<< HEAD
  const charityitem_body({super.key, required this.icon, this.color});
  final IconData icon;
  final Color? color;
=======
  const charityitem_body({super.key, required this.charityModel});
 final CharityModel charityModel;
>>>>>>> d1b92ec510280e76e32d52c3973ba365bcede513
=======
  const charityitem_body({
    super.key,
    required this.charityModel,
    required this.icon,
    this.color,
  });
  final CharityModel charityModel;

  final IconData icon;
  final Color? color;
>>>>>>> bef6ecd46f9596b2c4d31f925cd9d193d44ea4c5
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
<<<<<<< HEAD
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
=======
        child: Row(
          children: [
            CharityIcon(charityimage: charityModel.logoUrl!),

            SizedBox(width: 15),
            Text(charityModel.name!, style: TextStyle(fontSize: 18)),
            SizedBox(width: 25),
            Spacer(),
            IconButton(
              onPressed: () {
                context.push("/charities/chaaritedetelies");
              },
>>>>>>> d1b92ec510280e76e32d52c3973ba365bcede513

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
