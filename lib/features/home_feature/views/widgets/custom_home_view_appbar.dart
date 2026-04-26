import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/authprovider.dart/authprovider.dart';
import 'package:waslet_khier/features/donation_feature/data/models/donation_model.dart';

class CustomHomeViewAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomHomeViewAppbar({super.key, required this.onmenuTap});
  final VoidCallback? onmenuTap;
  @override
  Size get preferredSize => const Size.fromHeight(70);
  @override
  Widget build(BuildContext context) {
    final donor = context.watch<AuthProvider_info>().donor;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: appcolor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onmenuTap,
                icon: const Icon(Icons.menu_outlined, color: Colors.white),
              ),

              IconButton(
                onPressed: () {
                  if (donor == null) return;
                  final token = context.read<AuthProvider_info>().token ?? '';
                  context.go(
                    "/home/notification",
                    extra: {'donor': donor!, 'token': token},
                  );
                },
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                ' ${donor?.fullName ?? "user name"}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFFCFCFC),
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 8),
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                  donor?.imageUrl ??
                      'https://img.freepik.com/premium-vector/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-vector-illustration_561158-3396.jpg?semt=ais_hybrid&w=740&q=80',
                ),
                onBackgroundImageError: (_, __) {},
                backgroundColor: Colors.grey.shade200,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
