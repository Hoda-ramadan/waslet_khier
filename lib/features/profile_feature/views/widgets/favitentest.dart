import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/build_place_holder.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/donate_now_buttom.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/progress_parth_with_label.dart';
import 'package:waslet_khier/features/profile_feature/data/models/favorite_model/favorite_model.dart';

class favitemtext extends StatefulWidget {
  const favitemtext({super.key, this.item});
  final FavoriteModel? item;

  @override
  State<favitemtext> createState() => _favitemtextState();
}

class _favitemtextState extends State<favitemtext> {
  CaseModel? _caseModel;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchCase();
  }

  Future<void> _fetchCase() async {
    if (widget.item?.caseId == null) {
      setState(() => _loading = false);
      return;
    }
    try {
      final data = await ApiService(
        Dio(),
      ).get(endPoint: '/Case/${widget.item!.caseId}');
      if (mounted) {
        setState(() {
          _caseModel = CaseModel.fromJson(data as Map<String, dynamic>);
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double target = (_caseModel?.targetAmount ?? 1).toDouble();
    final double collected = (_caseModel?.collectedAmount ?? 0).toDouble();
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
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // القلب والزرار على اليسار
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
                    Expanded(
                      child: DonateNowButtom(
                        fontSize: 10,
                        caseModel: CaseModel(),
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
                  child: _loading
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: appcolor,
                              ),
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // اسم الجمعية
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Text(
                                    _caseModel?.charityName ?? "",
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

                            const SizedBox(height: 4),

                            // عنوان الحالة
                            Text(
                              _caseModel?.title ?? widget.item?.caseTitle ?? "",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),

                            const SizedBox(height: 8),

                            // تم جمع والمتبقي
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Flexible(
                                  child: Text(
                                    "${remaining.toStringAsFixed(0)} ج.م",
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: appcolor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    "تم جمع: ${collected.toStringAsFixed(0)} ج.م",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[700],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 4),

                            // Progress bar
                            ProgressBarWithLabel(progress: progress),

                            const SizedBox(height: 4),

                            // النسبة والمبلغ المتبقي label
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "المبلغ المتبقي",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
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

              // الصورة — بتيجي من caseModel
              Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: _loading
                      ? SizedBox(
                          width: 85,
                          height: 95,
                          child: buildPlaceholder(
                            isLoading: true,
                            hight: 95,
                            border: 14,
                          ),
                        )
                      : _caseModel?.coverImageUrl != null
                      ? Image.network(
                          _caseModel!.coverImageUrl!,
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
