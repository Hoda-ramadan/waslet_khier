import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/authprovider.dart/authprovider.dart';
import '../admin_constants.dart';

class AdminHeader extends StatelessWidget implements PreferredSizeWidget {
  final int charityId;
  const AdminHeader({super.key, required this.charityId});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final admin = context.read<AuthProvider_info>().admin;
    final token = context.read<AuthProvider_info>().token.toString();

    return Container(
      color: appcolor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Avatar + Name
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white.withOpacity(0.25),
                  backgroundImage: admin?.imageUrl != null
                      ? NetworkImage(admin!.imageUrl!)
                      : null,
                  child: admin?.imageUrl == null
                      ? Text(
                          admin?.firstName.substring(0, 1).toUpperCase() ?? 'A',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 8),
                Text(
                  admin?.firstName ?? 'Admin',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),

            GestureDetector(
              onTap: () {
                context.push(
                  '/admin/$charityId/notification',
                  extra: {
                    // 'donor': context.read<AuthProvider_info>().admin,
                    token,
                  },
                );
              },
              child: Stack(
                children: [
                  const Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                    size: 26,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: kAdminOrange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
