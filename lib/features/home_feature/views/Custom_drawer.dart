import 'package:flutter/material.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/drawer_item.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xffEDE7F6), // لون الخلفية
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
            Column(
              children: const [
                Icon(Icons.favorite, color: Colors.orange, size: 40),
                SizedBox(height: 10),
                Text(
                  "وصلة خير",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // العناصر
            DrawerItem(icon:Icons.business,title:  "الجمعيات الخيرية"),
            DrawerItem(icon:Icons.people, title: "الحالات"),
            DrawerItem(icon:Icons.calculate, title: "حساب الزكاة"),
            DrawerItem(icon:Icons.person_add,title:  "انضم إلينا"),
            DrawerItem(icon :Icons.share,title:  "شارك التطبيق"),

            const Spacer(),

            // privacy
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "تطبق الشروط والأحكام وسياسة الخصوصية",
                style: TextStyle(fontSize: 12, color: Colors.orange),
              ),
            )
          ],
        ),
      ),
    );
  }
}
  