import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/customItemCategory.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/statescardofcharity.dart';

class CategoryView_body extends StatelessWidget {
  const CategoryView_body({super.key, required this.charityModel});
  final CharityModel charityModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          cstomItem(),
          SizedBox(height: 20),
          StatesCardGridViewOfcharity(charityModel: charityModel),
        ],
      ),
    );
  }
}
