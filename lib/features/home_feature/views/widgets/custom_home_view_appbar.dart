import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';

class CustomHomeViewAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomHomeViewAppbar({super.key, required this.onmenuTap});
  final VoidCallback? onmenuTap;
  @override
  Size get preferredSize => const Size.fromHeight(70);
  @override
  Widget build(BuildContext context) {
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
                ' مرحبا\nNourhan',
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
                child: Image.asset(
                  'assets/images/Rectangle 2.png',
                  width: 38,
                  height: 38,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
