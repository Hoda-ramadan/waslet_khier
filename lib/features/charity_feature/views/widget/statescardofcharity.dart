import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/home_feature/data/models/state_model.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/detals_buttom.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/donate_now_buttom.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/progress_parth_with_label.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/states_card.dart';

class StatesCardGridViewOfcharity extends StatelessWidget {
  const StatesCardGridViewOfcharity({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 12),
            child: SizedBox(
              width: 140,
              child: StatesCardofcharity(stateModel: StateModel()),
            ),
          );
        },
      ),
    );
  }
}

class StatesCardofcharity extends StatelessWidget {
  const StatesCardofcharity({super.key, required this.stateModel});
  final StateModel stateModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.asset(
                stateModel.statesImage,
                height: 60,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            //  ده اللي بيخلي المحتوى يتمدد
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  Title
                    Text(
                      stateModel.stateName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // 🔹 Description
                    Text(
                      stateModel.stateDecription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 10),
                    ),

                    const SizedBox(height: 6),

                    //  Organization
                    const SizedBox(height: 6),

                    //  Percentage
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${stateModel.persantage}%"),
                        const Text(
                          "المبلغ المتبقي",
                          style: TextStyle(fontSize: 8),
                        ),
                      ],
                    ),

                    Text(
                      stateModel.remandMony.toString(),
                      style: TextStyle(color: appcolor, fontSize: 10),
                    ),

                    const SizedBox(height: 4),

                    // 🔹 Progress
                    SizedBox(
                      height: 4,
                      child: ProgressBarWithLabel(
                        progress: stateModel.persantage / 100,
                      ),
                    ),

                    //  ده بيدفع الأزرار لتحت
                    const Spacer(),

                    //  Buttons
                    Row(
                      children: [
                        Expanded(child: DetalsButtom(height: 30, fontSize: 10)),
                        const SizedBox(width: 6),
                        Expanded(
                          child: DonateNowButtom(height: 30, fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
