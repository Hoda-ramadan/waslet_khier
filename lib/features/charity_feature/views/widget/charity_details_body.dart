import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/Api/api_service.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/CategoryCubit/categorycubit.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/charity_feature/data/repo/categoryrepo.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charityimage.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/collectionOfcards.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/connecting_info.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/customsections.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/pymentoption_item.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/statescardofcharity.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/persoinalinfo_view.dart';

class CharityDetailsView_body extends StatelessWidget {
  const CharityDetailsView_body({super.key, required this.charity});
  final CharityModel charity;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            customappbar(text: "تفاصيل الجمعية"),

            Charity_image(image: charity.logoUrl!),
            Text(
              charity.name ?? 'null',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                fontFamily: "Roboto",
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                charity.description ?? 'null',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Roboto",
                  color: Color(0xFF696B6A),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 20),
            colletionOfcard(
              totalDonorsCount: charity.totalDonorsCount!,
              totalProjectsCount: charity.totalProjectsCount!,
              totalRaisedAmount: charity.totalRaisedAmount!,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 35, bottom: 10),
              child: Align(
                alignment: AlignmentGeometry.bottomRight,
                child: Text(
                  "الاقسام",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            BlocProvider(
              create: (context) =>
                  Categorycubit(Categoryrepo(ApiService(Dio())))
                    ..getCategoriesByCharity(charity.id as int),
              child: CustomSections(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 35, bottom: 10),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "الحالات",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            StatesCardGridViewOfcharity(charityModel: charity),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  Icon(Icons.location_pin, color: tintAppColor),
                  SizedBox(height: 8),
                  Text(
                    "الموقع",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                child: Container(
                  height: 270,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/image.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  Icon(Icons.settings_input_antenna, color: tintAppColor),
                  SizedBox(height: 8),
                  Text(
                    "معلومات التواصل",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ConnectingInfo(
                  icon: Icons.email,
                  text: "البريد الالكتروني",
                  subtext: "${charity.email}",
                  fontsize1: 10,
                ),
                Spacer(),
                ConnectingInfo(
                  icon: Icons.phone_android,
                  text: 'رقم التواصل',
                  subtext: '${charity.phoneNumber}',
                  fontsize2: 14,
                ),
              ],
            ),
            SizedBox(height: 20),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  Icon(Icons.credit_card, color: tintAppColor),
                  SizedBox(height: 8),
                  Text(
                    "طرق الدفع",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PymentoptionItem(image: "assets/Frame 390.png"),

                PymentoptionItem(image: "assets/Frame 390.png"),

                PymentoptionItem(image: "assets/Frame 390.png"),
              ],
            ),
            SizedBox(height: 20),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  Icon(Icons.verified_user, color: tintAppColor),
                  SizedBox(height: 8),
                  Text(
                    "الوثائق الرسمية",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            ConnectingInfo(
              icon: Icons.folder_open,
              text: 'ترخيص وزارة التضامن الأجتماعي',
              subtext: 'تم التحقق منه في يناير2024',
              fontsize1: 20,
              fontsize2: 16,
              iconcolor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
