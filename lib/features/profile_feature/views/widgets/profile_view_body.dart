import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/personinfo_view.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/profile_item.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/radix-icons_avatar (1).png",
            width: 70,
            height: 105,
          ),
          Text("Nourhan"),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return PersonInfo_view();
                  },
                ),
              );
            },
            child: profileItem(
              icon: Icons.person_outlined,
              text: 'المعلومات الشخصية',
            ),
          ),
          SizedBox(height: 20),
          profileItem(
            icon: Icons.favorite_border,
            text: "المفضلة",
            color: Colors.red,
          ),
          SizedBox(height: 20),
          profileItem(
            icon: FontAwesomeIcons.handHoldingHeart,
            text: "طرق التبرع",
          ),
          SizedBox(height: 20),
          profileItem(icon: Icons.error_outline, text: "حول التطبيق"),
          SizedBox(height: 20),
          profileItem(
            icon: Icons.logout,
            text: "تسجيل الخروج",
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
