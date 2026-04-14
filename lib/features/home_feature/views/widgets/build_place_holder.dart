import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';

class buildPlaceholder extends StatelessWidget {
  final bool isLoading;
  final double hight;
  final double border  ;
  const buildPlaceholder({super.key, this.isLoading = false , required this. hight  , required this.border});

  @override
  Widget build(BuildContext context) {
  ; // غيرها حسب مشروعك

    return Container(
      height:  hight,  // 110,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(border),
        gradient: LinearGradient(
          colors: [appcolor.withOpacity(0.15), appcolor.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: appcolor,
                  ),
                )
              : Icon(
                  Icons.volunteer_activism, // charity-themed icon
                  size: 36,
                  color: appcolor.withOpacity(0.5),
                ),
          const SizedBox(height: 6),
          Text(
            isLoading ? 'جاري التحميل...' : 'لا توجد صورة',
            style: TextStyle(fontSize: 9, color: appcolor.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }
}