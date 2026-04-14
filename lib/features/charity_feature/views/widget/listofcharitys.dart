import 'package:flutter/material.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charity_item.dart';

class Listofcharitys extends StatelessWidget {
  const Listofcharitys({super.key, this.icon, this.color});
  final IconData? icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, item) {
        return CharityItem(icon: icon, color: color);
      },
    );
  }
}
