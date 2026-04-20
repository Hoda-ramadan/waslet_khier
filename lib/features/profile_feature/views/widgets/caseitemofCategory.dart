import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/progress_parth_with_label.dart';

class CaseItemOfcategory extends StatelessWidget {
  const CaseItemOfcategory({super.key});
  final double progress = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: tintAppColor),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey,
            ),
            child: IconButton(
              onPressed: () {},
              color: Colors.red,
              icon: Icon(Icons.favorite),
            ),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // المكان
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(Icons.location_pin, color: Colors.grey, size: 14),
                    SizedBox(width: 4),
                    Text(
                      "مركز علاج الأورام بسوهاج",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // العنوان
                const Text(
                  "جلسة علاج كيماوي لمريض سرطان",
                  style: TextStyle(fontSize: 14),
                ),

                const SizedBox(height: 8),

                // الصف اللي فيه النسبة + الزر
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 10), // النسبة والمبلغ
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("800 ج.م", style: TextStyle(fontSize: 13)),
                              Text(
                                "المبلغ المتبقي",
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),

                          const SizedBox(height: 4),

                          const Text("60%", style: TextStyle(fontSize: 10)),

                          const SizedBox(height: 4),

                          ProgressBarWithLabel(progress: progress),
                          SizedBox(
                            height: 35,
                            child: ElevatedButton(
                              onPressed: () {
                                if (progress != 1) {
                                  context.go("/profile/PaymentwayView");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: progress != 1
                                    ? tintAppColor
                                    : Colors.grey,
                              ),
                              child: const Text(
                                "تبرع الآن",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),

                    // الزر جنب الـ progress
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // الصورة يمين
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/images/patiant.png",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
