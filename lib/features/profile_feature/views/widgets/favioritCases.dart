import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charityicon.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/custom_app_Bar.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/listofcharitys.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/progress_parth_with_label.dart';
import 'package:waslet_khier/features/profile_feature/data/favCubit/favCubit.dart';
import 'package:waslet_khier/features/profile_feature/data/favCubit/favstate.dart';
import 'package:waslet_khier/features/profile_feature/data/favrepo/FavoriteRepo.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/caseitemofCategory.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/cstomfavRow.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/favoriteCharity_body.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/favorite_view.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/persoinalinfo_view.dart';

class Favioritcases extends StatelessWidget {
  const Favioritcases({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: CustomAppBar(),
      body: BlocProvider(
        create: (context) => Favcubit(Favoriterepo(ApiService(Dio()))),
        child: Favioritcases_body(),
      ),
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

class CasesTab extends StatefulWidget {
  const CasesTab({super.key});

  @override
  State<CasesTab> createState() => _CasesTabState();
}

class _CasesTabState extends State<CasesTab> {
  @override
  void initState() {
    super.initState();
    // هنا بنطلب البيانات لما الويدجت يتبني
    context.read<Favcubit>().getfav();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Favcubit, FavorieState>(
      builder: (context, state) {
        // حالة اللودينج
        if (state is favoritLodaing) {
          return const Center(child: CircularProgressIndicator());
        }

        // حالة النجاح
        if (state is FavoritSuccess) {
          if (state.favorit.isEmpty) {
            return FavoriteView();
          }

          return ListView.builder(
            itemCount: state.favorit.length,
            itemBuilder: (context, index) {
              final item = state.favorit[index];
              return Padding(
                padding: const EdgeInsets.all(12),
                child: CaseItemOfcategory(
                  // مررري بيانات الـ item للويدجت
                  // caseTitle: item.caseTitle,
                  // coverImageUrl: item.coverImageUrl,
                ),
              );
            },
          );
        }

        // حالة الفشل
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
                  onPressed: () => context.read<Favcubit>().getfav(),
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
