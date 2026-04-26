import 'package:flutter/material.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/customtextfeild.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/listofcharitys.dart';

class CharityPageBody extends StatelessWidget {
  const CharityPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Customtextfeild(),
            SizedBox(height: 30),

            SizedBox(
              height: 500,
              child: Listofcharitys(icon: Icons.arrow_forward_ios_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
