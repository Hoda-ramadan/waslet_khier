import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/progress_parth_with_label.dart';
import 'package:waslet_khier/features/profile_feature/data/favCubit/favCubit.dart';

class CaseItemOfcategory extends StatelessWidget {
  const CaseItemOfcategory({
    super.key,
    required this.caseId,
    required this.caseTitle,
    required this.location,
    required this.remaining,
    required this.progress,
    required this.token, // ✅ التوكن
    this.coverImageUrl,
  });

  final int caseId;
  final String caseTitle;
  final String location;
  final String remaining;
  final double progress;
  final String token;
  final dynamic coverImageUrl;

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
          // ✅ زرار القلب مربوط بالـ Cubit
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
            ),
            child: IconButton(
              onPressed: () {
                context.read<Favcubit>().addFavorite(
                  caseId: caseId,
                  token: token,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تمت الإضافة للمفضلة ✓')),
                );
              },
              color: Colors.red,
              icon: const Icon(
                Icons.favorite_border,
              ), // ✅ border لأنها مش مضافة
            ),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.location_pin,
                      color: Colors.grey,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location, // ✅ من الـ API
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(caseTitle), // ✅ من الـ API
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(remaining), // ✅ من الـ API
                              const Text(
                                "المبلغ المتبقي",
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: coverImageUrl != null
                ? Image.network(
                    coverImageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
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

extension on Favcubit {
  void addFavorite({required int caseId, required String token}) {}
}
