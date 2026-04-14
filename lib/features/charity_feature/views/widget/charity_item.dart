import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/charity_feature/views/charity_detels_view.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charityItem_body.dart';

class CharityItem extends StatelessWidget {
<<<<<<< HEAD
  const CharityItem({super.key, required this.icon, this.color});
  final IconData? icon;
  final Color? color;
=======
  const CharityItem({super.key, required this.charityModel});
 final CharityModel charityModel ; 
>>>>>>> d1b92ec510280e76e32d52c3973ba365bcede513
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return CharityDetelsView();
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: tintAppColor),
            borderRadius: BorderRadius.circular(24),
          ),
<<<<<<< HEAD
          child: charityitem_body(
            icon: icon ?? Icons.arrow_forward_ios_outlined,
            color: color,
          ),
=======
          child: charityitem_body(charityModel: charityModel,),
>>>>>>> d1b92ec510280e76e32d52c3973ba365bcede513
        ),
      ),
    );
  }
}
