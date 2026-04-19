import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/listofcharitys.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/cstomfavRow.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/persoinalinfo_view.dart';

class Favoritecharity_body extends StatelessWidget {
  const Favoritecharity_body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            customappbar(text: "المفضلة"),
            SizedBox(height: 20),
            cstomfavRow(location: '/profile/Favoritecharity/Favioritcases'),
            SizedBox(height: 30),
            SizedBox(
              height: 600,
              child: Listofcharitys(icon: Icons.favorite, color: Colors.red),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
