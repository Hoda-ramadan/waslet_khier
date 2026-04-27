import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/charity_deteals_cubit.dart';
import 'package:waslet_khier/features/charity_feature/data/repo/charity_repo.dart';
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


  List<Widget> get _screens => [
    AdminHomeView(charityId: widget.charityId),
    AdminCasesView(charityId: widget.charityId),
    BlocProvider(
      create: (_) => CharityDetealsCubit(
        CharityRepo(ApiService(Dio())),
      ),
      child: AdminSettingsView(charityId: widget.charityId),
    ),
  ];

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