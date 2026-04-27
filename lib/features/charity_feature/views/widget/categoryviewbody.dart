import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_madel2/category_madel2.dart';

import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/customItemCategory.dart';

import 'package:waslet_khier/features/home_feature/views/widgets/build_place_holder.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/donate_now_buttom.dart';

class CategoryView_body extends StatefulWidget {
  const CategoryView_body({
    super.key,
    required this.categoryId,
    required this.categoryMadel,
  });
  final int categoryId;
  final CategoryMadel categoryMadel;

  @override
  State<CategoryView_body> createState() => _CategoryView_bodyState();
}

class _CategoryView_bodyState extends State<CategoryView_body> {
  List<CaseModel> _cases = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchCases();
  }

  Future<void> _fetchCases() async {
    try {
      final data = await ApiService(
        Dio(),
      ).get(endPoint: '/Case/category/${widget.categoryId}');
      final list = data as List;
      setState(() {
        _cases = list.map((e) => CaseModel.fromJson(e)).toList();
        _loading = false;
      });
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              IconButton(
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_forward_ios_outlined, color: appcolor),
              ),
            ],
          ),
          const SizedBox(height: 10),
          cstomItem(category: widget.categoryMadel),
          const SizedBox(height: 20),
          _loading
              ? const Center(child: CircularProgressIndicator(color: appcolor))
              : Expanded(child: CustomGridView(cases: _cases)),
        ],
      ),
    );
  }
}

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key, required this.cases});
  final List<CaseModel> cases;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: cases.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.60,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.push('/cases/case_detals_view', extra: cases[index]);
          },
          child: StatesCard(casee: cases[index]),
        );
      },
    );
  }
}

class StatesCard extends StatelessWidget {
  const StatesCard({super.key, required this.casee});

  final CaseModel casee;

  @override
  Widget build(BuildContext context) {
    final double target = (casee.targetAmount ?? 1).toDouble();
    final double collected = (casee.collectedAmount ?? 0).toDouble();

    final double progress = target == 0
        ? 0
        : (collected / target).clamp(0.0, 1.0);

    final double remaining = (target - collected).clamp(0, double.infinity);
    final int percentage = (progress * 100).toInt();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // 🔹 Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: casee.coverImageUrl != null
                ? Image.network(
                    casee.coverImageUrl!,
                    height: 130,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => buildPlaceholder(
                      isLoading: false,
                      hight: 110,
                      border: 0,
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return buildPlaceholder(
                        isLoading: true,
                        hight: 110,
                        border: 0,
                      );
                    },
                  )
                : buildPlaceholder(isLoading: true, hight: 110, border: 0),
          ),

          // 🔹 Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 🔹 Title + Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        casee.title ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        casee.description ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),

                  //  أضف هنا Progress Bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey[200],
                        color: tintAppColor,
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$percentage%",
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "المتبقي: ${remaining.toStringAsFixed(0)} ج",
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // 🔹 Button
                  Row(
                    children: [
                      Expanded(
                        child: DonateNowButtom(
                          height: 30,
                          fontSize: 10,
                          caseModel: casee,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
