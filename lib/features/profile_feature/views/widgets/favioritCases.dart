import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/featureAuth/authprovider.dart/authprovider.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';
import 'package:waslet_khier/features/profile_feature/data/favCubit/favCubit.dart';
import 'package:waslet_khier/features/profile_feature/data/favCubit/favstate.dart';
import 'package:waslet_khier/features/profile_feature/data/favrepo/FavoriteRepo.dart';
import 'package:waslet_khier/features/profile_feature/data/models/favorite_model/favorite_model.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/caseitemtest.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/cstomfavRow.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/favitentest.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/favorite_view.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/favoriteview_body.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/persoinalinfo_view.dart';

class Favioritcases extends StatelessWidget {
  const Favioritcases({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ جيبي الـ donorId من الـ AuthProvider
    final donorId =
        Provider.of<AuthProvider_info>(context, listen: false).donor?.id ?? 0;

    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: CustomAppBar(),
      body: BlocProvider(
        create: (context) =>
            Favcubit(Favoriterepo(ApiService(Dio())))..getfav(donorId),
        child: Favioritcases_body(),
      ),
    );
  }
}

class Favioritcases_body extends StatelessWidget {
  const Favioritcases_body({super.key, this.caseModel});
  final CaseModel? caseModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            customappbar(text: "المفضلة"),

            const SizedBox(height: 30),
            SizedBox(
              height: 600,
              width: double.infinity,
              child: CaseItemTest(),
            ),
          ],
        ),
      ),
    );
  }
}

class CasesTab extends StatelessWidget {
  const CasesTab({super.key, this.caseModel});
  final CaseModel? caseModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Favcubit, FavorieState>(
      builder: (context, state) {
        if (state is favoritLodaing) {
          return const Center(
            child: CircularProgressIndicator(color: appcolor),
          );
        }

        if (state is FavoritSuccess) {
          if (state.favorit.isEmpty) {
            return const FavoriteView_body();
          }
          return ListView.builder(
            itemCount: state.favorit.length,
            itemBuilder: (context, index) {
              final item = state.favorit[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: () {
                    context.push(
                      '/cases/case_detals_view',
                      extra: state.favorit[index],
                    );
                  },
                  child: favitemtext(item: item),
                ),
              );
            },
          );
        }

        if (state is FavoritFaild) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 50, color: Colors.red),
                const SizedBox(height: 10),
                Text(state.errorMessage),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    final donorId =
                        Provider.of<AuthProvider_info>(
                          context,
                          listen: false,
                        ).donor?.id ??
                        0;
                    context.read<Favcubit>().getfav(donorId);
                  },
                  child: const Text("إعادة المحاولة"),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}

class _FavCaseItem extends StatelessWidget {
  const _FavCaseItem({required this.item});
  final FavoriteModel item;

  @override
  Widget build(BuildContext context) {
    final donorId =
        Provider.of<AuthProvider_info>(context, listen: false).donor?.id ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: tintAppColor),
      ),
      child: Row(
        children: [
          // ✅ زرار القلب الحقيقي
          IconButton(
            onPressed: () {
              context.read<Favcubit>().toggleFavorite(
                donorId: donorId,
                caseId: item.caseId!,
              );
            },
            icon: const Icon(Icons.favorite, color: Colors.red),
          ),
          const SizedBox(width: 10),

          // بيانات الحالة
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.caseTitle ?? 'حالة',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'المتبرع: ${item.donorName ?? ''}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // صورة الحالة
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: item.coverImageUrl != null
                ? Image.network(
                    item.coverImageUrl.toString(),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _placeholder(),
                  )
                : _placeholder(),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(Icons.image, color: Colors.grey),
    );
  }
}
