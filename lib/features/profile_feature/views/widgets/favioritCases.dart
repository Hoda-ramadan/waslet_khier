import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charityicon.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/listofcharitys.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/progress_parth_with_label.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/caseitemofCategory.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/cstomfavRow.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/favoriteCharity_body.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/persoinalinfo_view.dart';

class Favioritcases extends StatelessWidget {
  const Favioritcases({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: CustomAppBar(),
      body: Favioritcases_body(),
    );
  }
}

class Favioritcases_body extends StatelessWidget {
  const Favioritcases_body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            customappbar(text: "المفضلة"),
            SizedBox(height: 20),
            cstomfavRow2(location: "/profile/Favoritecharity"),
            SizedBox(height: 30),
            SizedBox(height: 600, width: double.infinity, child: CasesTab()),
          ],
        ),
      ),
    );
  }
}

class CasesTab extends StatelessWidget {
  const CasesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: CaseItemOfcategory(),
        );
      },
    );
  }
}

class cstomfavRow2 extends StatelessWidget {
  const cstomfavRow2({super.key, required this.location});
  final String location;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            child: Text(
              "الجمعيات",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            context.push(location);
          },

          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: tintAppColor,
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              "الحالات",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
