import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/profile_feature/data/models/favorite_model/favorite_model.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/build_place_holder.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/progress_parth_with_label.dart';

class favitemtext extends StatelessWidget {
  const favitemtext({super.key, this.item, this.caseModel});
  final FavoriteModel? item;
  final CaseModel? caseModel;

  @override
  Widget build(BuildContext context) {
    final double target = (caseModel?.targetAmount ?? 1).toDouble();
    final double collected = (caseModel?.collectedAmount ?? 0).toDouble();
    final double progress = target == 0
        ? 0
        : (collected / target).clamp(0.0, 1.0);
    final double remaining = (target - collected).clamp(0, double.infinity);
    final int percentage = (progress * 100).toInt();

    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tintAppColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        minimumSize: const Size(0, 0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          "تبرع الان",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // المحتوى في المنتصف
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // الموقع / اسم الجهة
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              caseModel?.charityName ?? "",
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.location_on,
                            color: Colors.grey,
                            size: 14,
                          ),
                        ],
                      ),

                      const SizedBox(height: 4), // عنوان الحالة
                      Text(
                        caseModel?.title ?? item?.caseTitle ?? "",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),

                      const SizedBox(height: 8),

                      // تم جمع
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // ✅ المبلغ المتبقي بلون appcolor
                          Text(
                            "${remaining} ج.م",
                            style: const TextStyle(
                              fontSize: 11,
                              color: appcolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "تم جمع: ${collected} ج.م",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      // ✅ نفس ProgressBarWithLabel من StatesCard
                      ProgressBarWithLabel(progress: progress),

                      const SizedBox(height: 4),

                      // النسبة والمبلغ المتبقي label
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "المبلغ المتبقي",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                          Text(
                            "$percentage%",
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // الصورة
              // الصورة
              Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: caseModel?.coverImageUrl != null
                      ? Image.network(
                          caseModel!.coverImageUrl!,
                          width: 85,
                          height: 95,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              SizedBox(
                                width: 85,
                                height: 95,
                                child: buildPlaceholder(
                                  isLoading: false,
                                  hight: 95,
                                  border: 14,
                                ),
                              ),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return SizedBox(
                              width: 85,
                              height: 95,
                              child: buildPlaceholder(
                                isLoading: true,
                                hight: 95,
                                border: 14,
                              ),
                            );
                          },
                        )
                      : SizedBox(
                          width: 85,
                          height: 95,
                          child: buildPlaceholder(
                            isLoading: false,
                            hight: 95,
                            border: 14,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
