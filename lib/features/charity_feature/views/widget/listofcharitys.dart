import 'package:flutter/material.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charity_item.dart';

class Listofcharitys extends StatelessWidget {
  const Listofcharitys({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, item) {
        return CharityItem();
      },
    );
  }
}
