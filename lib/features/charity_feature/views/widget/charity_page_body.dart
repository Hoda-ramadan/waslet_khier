import 'package:flutter/material.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/textfield.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/customtextfeild.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/listofcharitys.dart';

class CharityPageBody extends StatelessWidget {
  const CharityPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 60)),
            SliverToBoxAdapter(child: Customtextfeild()),
            SliverToBoxAdapter(child: SizedBox(height: 30)),
            SliverToBoxAdapter(
              child: SizedBox(height: 600, child: Listofcharitys()),
            ),
          ],
        ),
      ),
    );
  }
}
