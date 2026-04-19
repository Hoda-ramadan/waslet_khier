import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/featureAuth/authprovider.dart/authprovider.dart';

import 'package:waslet_khier/features/profile_feature/views/widgets/profile_item.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final donor = context.watch<AuthProvider_info>().donor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Image.asset(
            "assets/images/radix-icons_avatar (1).png",
            width: 70,
            height: 105,
          ),
          Text("${donor?.firstName ?? "User"}"),
          SizedBox(height: 20),
          profileItem(
            onTap: () {
              context.push('/profile/personInfo');
            },
            icon: Icons.person_outlined,
            text: 'المعلومات الشخصية',
          ),
          SizedBox(height: 20),
          profileItem(
            onTap: () {
              context.push('/profile/Favoritecharity');
            },
            icon: Icons.favorite_border,
            text: "المفضلة",
            color: Colors.red,
          ),
          SizedBox(height: 20),
          profileItem(
            onTap: () {
              context.push("/profile/PaymentwayView");
            },
            icon: FontAwesomeIcons.handHoldingHeart,
            text: "طرق التبرع",
          ),
          SizedBox(height: 20),
          profileItem(
            onTap: () {
              context.push("/profile/AboutappView");
            },
            icon: Icons.error_outline,
            text: "حول التطبيق",
          ),
          SizedBox(height: 20),
          profileItem(
            onTap: () {
              context.push('/profile/logout');
            },
            icon: Icons.logout,
            text: "تسجيل الخروج",
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
