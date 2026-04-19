import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/class/assets.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/drawer_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromARGB(255, 241, 249, 247), // لون الخلفية
        child: Column(
          children: [
            const SizedBox(height: 40),

            // زرار القفل (X)
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            // اللوجو
            Column(children: [Image.asset(Assets.logoimage)]),

            const SizedBox(height: 40),

            // العناصر
            DrawerItem(
              icon: Icons.business,
              title: "الجمعيات الخيرية",
              onTap: () {
                context.go("/charities");
              },
            ),
            DrawerItem(
              icon: Icons.people,
              title: "الحالات",
              onTap: () {
                context.go("/cases");
              },
            ),
            GestureDetector(
              onTap: () {
                context.go('/home/zakatView');
                ;
              },
              child: DrawerItem(
                icon: Icons.calculate,
                title: "حساب الزكاة",
                onTap: () {
                  context.go("/home/zakatView");
                },
              ),
            ),
            DrawerItem(
              icon: Icons.person_add,
              title: "انضم إلينا",
              onTap: () {
                context.go("/profile/logout/createacc");
              },
            ),
            DrawerItem(icon: Icons.share, title: "شارك التطبيق"),

            const Spacer(),

            // privacy
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "تطبق الشروط والأحكام وسياسة الخصوصية",
                style: TextStyle(fontSize: 12, color: tintAppColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
