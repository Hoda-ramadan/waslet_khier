import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charityicon.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "الجمعيات",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
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
              ],
            ),
            SizedBox(height: 30),
            Faviortecaseitem(),
          ],
        ),
      ),
    );
  }
}

class Faviortecaseitem extends StatelessWidget {
  const Faviortecaseitem({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          children: [
            charityicon(),
            SizedBox(width: 15),
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.grey),
                    Text(
                      "مركز علاج الأورام بسوهاج",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: () {},

                        icon: Icon(Icons.favorite, color: Colors.red),
                      ),
                    ),
                  ],
                ),
                Text("جلسة علاج كيماوي لمريض سرطان"),
              ],
            ),
            // Text("مركز علاج الأورام بسوهاج", style: TextStyle(fontSize: 18)),
            SizedBox(width: 25),
          ],
        ),
      ),
    );
  }
}
