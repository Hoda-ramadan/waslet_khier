import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';

class CharitesCard extends StatelessWidget {
  const CharitesCard({super.key, required this.charityModel});
  final CharityModel charityModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/home/chaaritedetelies', extra: charityModel);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.30, color: appcolor),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // الصورة
            charityModel.logoUrl != null && charityModel.logoUrl!.isNotEmpty
                ? Image.network(
                    charityModel.logoUrl!,
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _smallPlaceholder(),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return _smallPlaceholder();
                    },
                  )
                : _smallPlaceholder(),

            const SizedBox(height: 4),

            // الاسم - سطر واحد فقط
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                charityModel.name ?? '',
                textAlign: TextAlign.center,
                maxLines: 1, // ← منع التفاف السطر
                overflow: TextOverflow.ellipsis, // ← نقاط إذا كان طويلاً
                style: const TextStyle(
                  color: Color(0xFF040504),
                  fontSize: 9, // ← أصغر قليلاً للأمان
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallPlaceholder() {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: appcolor.withOpacity(0.1),
      ),
      child: Icon(
        Icons.volunteer_activism,
        size: 16,
        color: appcolor.withOpacity(0.5),
      ),
    );
  }
}
