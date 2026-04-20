import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'admin_constants.dart';
import 'views/admin_home_view.dart';
import 'views/admin_cases_view.dart';
import 'views/admin_settings_view.dart';

class AdminMainScreen extends StatefulWidget {
  final int charityId;
  const AdminMainScreen({super.key, required this.charityId});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    print('>>> AdminMainScreen charityId: ${widget.charityId}');
    _screens = [
      AdminHomeView(charityId: widget.charityId),
      AdminCasesView(charityId: widget.charityId), // ✅ pass charityId
      const AdminSettingsView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAdminBackground,
      body: _screens[_currentIndex],
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: appcolor,
          unselectedItemColor: kAdminTextGrey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 12,
          onTap: (i) => setState(() => _currentIndex = i),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded),
              label: 'الحالات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded),
              label: 'الإعدادات',
            ),
          ],
        ),
      ),
    );
  }
}